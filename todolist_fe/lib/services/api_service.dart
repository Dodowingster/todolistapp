import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<Map<String, dynamic>>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/todolist/task/'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load tasks: ${response.statusCode}');
    }
  }

  static Future<void> createTask(Map<String, dynamic> taskData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todolist/task/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(taskData),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create task: ${response.statusCode}');
    }
  }

  static Future<void> updateTask(int taskId, Map<String, dynamic> taskData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todolist/task/$taskId/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(taskData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task: ${response.statusCode}');
    }
  }

  static Future<void> deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse('$baseUrl/todolist/task/$taskId/'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task: ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchTasksWithDateTime() async {
  final response = await http.get(Uri.parse('$baseUrl/todolist/task/'));
  if (response.statusCode == 200) {
    List<Map<String, dynamic>> tasks = List<Map<String, dynamic>>.from(json.decode(response.body));
    tasks.forEach((task) {
      DateTime dateTime = DateTime.parse(task['created_at']); 
      String formattedDate = DateFormat('EEE, d/m/y').format(dateTime);
      task['formattedDate'] = formattedDate;
    });
    return tasks;
  } else {
    throw Exception('Failed to load tasks: ${response.statusCode}');
  }
}

 static Future<List<Map<String, dynamic>>> fetchTaskWithNewDateTime() async {
  final response = await http.get(Uri.parse('$baseUrl/todolist/task/'));
  if (response.statusCode == 200) {
    List<Map<String, dynamic>> tasks = List<Map<String, dynamic>>.from(json.decode(response.body));
    tasks.forEach((task) {
      DateTime dateTime = DateTime.parse(task['updated_at']); 
      String formattedDate = DateFormat('EEE, d/m/y').format(dateTime);
      task['formattedDate'] = formattedDate;
    });
    return tasks;
  } else {
    throw Exception('Failed to load tasks: ${response.statusCode}');
  }
}


}

