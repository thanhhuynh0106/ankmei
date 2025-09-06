import 'dart:convert';

import 'package:ankmei_app/custom_object/task.dart';
import 'package:ankmei_app/env.dart';
import 'package:ankmei_app/providers/current_user_store.dart';
import 'package:http/http.dart' as http;

class TaskService {
  TaskService._internal();
  static final TaskService instance = TaskService._internal();

  Future<Task?> createTask(Task task) async {
    final token = CurrentUserStore.instance.token;
    if (token == null) return null;

    final uri = Uri.parse('${Env.apiUrl}/tasks');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'auth-token': token,
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Task.fromJson(data);
    } 
    return null;
  } 
}