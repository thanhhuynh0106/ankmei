import 'dart:convert';

import 'package:ankmei_app/custom_object/user.dart';
import 'package:ankmei_app/env.dart';
import 'package:ankmei_app/providers/current_user_store.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'current_user';

  Future<bool> login({required String username, required String password}) async {
    final uri = Uri.parse('${Env.apiUrl}/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      final String token = body['token'] as String;
      final Map<String, dynamic>? userJson = body['user'] as Map<String, dynamic>?;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      if (userJson != null) {
        await prefs.setString(_userKey, jsonEncode(userJson));
        CurrentUserStore.instance.setTokenAndUser(token: token, user: User.fromJson(userJson));
      } else {
        // fallback: fetch /users/me
        await fetchCurrentUserWithToken(token);
      }
      return true;
    }
    return false;
  }

  Future<bool> register({required String username, required String email, required String password}) async {
    final uri = Uri.parse('${Env.apiUrl}/auth/register');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      final String token = (body['token'] ?? '') as String;
      final Map<String, dynamic>? userJson = body['user'] as Map<String, dynamic>?;
      final prefs = await SharedPreferences.getInstance();
      if (token.isNotEmpty) await prefs.setString(_tokenKey, token);
      if (userJson != null) {
        await prefs.setString(_userKey, jsonEncode(userJson));
        CurrentUserStore.instance.setTokenAndUser(token: token, user: User.fromJson(userJson));
      }
      return true;
    }
    return false;
  }

  Future<void> fetchCurrentUserWithToken(String token) async {
    final uri = Uri.parse('${Env.apiUrl}/users/me');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'auth-token': token,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      final user = User.fromJson(json);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(json));
      CurrentUserStore.instance.setTokenAndUser(token: token, user: user);
    }
  }

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final userString = prefs.getString(_userKey);
    if (token != null && userString != null) {
      final Map<String, dynamic> json = jsonDecode(userString) as Map<String, dynamic>;
      CurrentUserStore.instance.setTokenAndUser(token: token, user: User.fromJson(json));
    } else if (token != null) {
      await fetchCurrentUserWithToken(token);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    CurrentUserStore.instance.clear();
  }
}


