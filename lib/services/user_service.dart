import 'dart:convert';

import 'package:ankmei_app/custom_object/user.dart';
import 'package:ankmei_app/env.dart';
import 'package:ankmei_app/providers/current_user_store.dart';
import 'package:http/http.dart' as http;

class UserService {
  UserService._internal();
  static final UserService instance = UserService._internal();

  Future<bool> updateUserProfile({
    String? displayName,
    String? bio,
    String? avatarUrl,
    String? backgroundUrl,
    List<String>? badgeIds,
  }) async {
    final token = CurrentUserStore.instance.token;
    if (token == null) return false;

    final Map<String, dynamic> updates = {};
    if (displayName != null) updates['displayName'] = displayName;
    if (bio != null) updates['bio'] = bio;
    if (avatarUrl != null) updates['avatarUrl'] = avatarUrl;
    if (backgroundUrl != null) updates['backgroundUrl'] = backgroundUrl;
    if (badgeIds != null) updates['badgeIds'] = badgeIds;
    
    final uri = Uri.parse('${Env.apiUrl}/users/me');
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'auth-token': token,
      },
      body: jsonEncode(updates),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      final user = User.fromJson(body);

      CurrentUserStore.instance.setUser(user);
      return true;
    }
    return false;
  }
}

Future<bool> updateUserBio(String bio) async {
  return await UserService.instance.updateUserProfile(bio: bio);
}

Future<bool> updateUserDisplayName(String displayName) async {
  return await UserService.instance.updateUserProfile(displayName: displayName);
}