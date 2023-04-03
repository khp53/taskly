import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly_new/screen/auth/auth_viewmodel.dart';
import '../../model/task.dart';
import '../viewmodel.dart';

class HomeViewmodel extends Viewmodel {
  HomeViewmodel() {
    getTasks();
  }
  List<Task> taskList = [];

  Stream<QuerySnapshot> todoStream =
      FirebaseFirestore.instance.collection('Todo').snapshots();

  AuthViewmodel authViewmodel = AuthViewmodel();

  // only the collection reference
  CollectionReference todo = FirebaseFirestore.instance.collection('Todo');

  addTaskFirebase(String taskName, String category) {
    return todo.add({
      'taskName': taskName,
      'category': category,
      'isCompleted': false,
    });
  }

  updateFirebase(String docId) {
    return todo.doc(docId).update({
      'isCompleted': true,
    });
  }

  deleteFirebase(String docId) {
    return todo.doc(docId).delete();
  }

  addTask(Task task) async {
    final pref = await SharedPreferences.getInstance();
    await getTasks();
    taskList.add(task);
    String rawJson = jsonEncode(taskList);
    pref.setString('taskList', rawJson);
  }

  getTasks() async {
    final pref = await SharedPreferences.getInstance();
    final rawJson = pref.getString('taskList');
    if (rawJson != null) {
      final map = await jsonDecode(rawJson);
      List<dynamic> dynamicList =
          await map.map((e) => Task.fromJson(e)).toList();
      return update(() async => taskList = dynamicList.cast<Task>());
    } else {
      return update(() async => taskList = []);
    }
  }

  updateTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    await getTasks();

    if (taskList.where((element) => element.name == task.name).isNotEmpty) {
      taskList.removeWhere((element) => element.name == task.name);
      taskList.add(task);
    }
    String rawJson = jsonEncode(taskList);
    prefs.setString('taskList', rawJson);
  }

  signOutFromApp() async {
    return await authViewmodel.signOut();
  }
}
