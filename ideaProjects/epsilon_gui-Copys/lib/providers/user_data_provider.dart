import 'dart:convert';
import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/providers/task_group_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  static final UserData _instance = UserData._internal();
  UserData._internal();

  static UserData get instance => _instance;

  int totalSpent = 0;
  int checkouts = 0;
  int failures = 0;
  double totalSpentDouble = 0.0;
  List<ProfileGroup> profileGroups = [];
  List<TaskGroup> taskGroups = [];

  int get totalSpent_ => totalSpent;
  double get spentDouble => totalSpentDouble;
  int get checkouts_ => checkouts;
  int get failures_ => failures;

  // Load data from SharedPreferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    totalSpentDouble = prefs.getDouble('totalSpentDouble') ?? 0;
    checkouts = prefs.getInt('checkouts') ?? 0;
    failures = prefs.getInt('failures') ?? 0;
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalSpentDouble', totalSpentDouble);
    await prefs.setInt('checkouts', checkouts);
    await prefs.setInt('failures', failures);
  }

  void addToTotalSpent(double valueAdded) {
    totalSpentDouble += valueAdded;
    _saveData();
    notifyListeners();
  }

  void incrementCheckouts() {
    checkouts += 1;
    _saveData();
    notifyListeners();
  }

  void incrementFailures() {
    failures += 1;
    _saveData();
    notifyListeners();
  }
}

  // // Save task groups to SharedPreferences as a JSON list
  // Future<void> saveTaskGroups(List<TaskGroup> taskGroups) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> taskGroupJsonList =
  //       taskGroups.map((taskGroup) => json.encode(taskGroup.toJson())).toList();
  //   await prefs.setStringList('taskGroups', taskGroupJsonList);
  // }

  // Load task groups from SharedPreferences and deserialize from JSON
  // Future<List<TaskGroup>> loadTaskGroups(SharedPreferences prefs) async {
  //   List<String> taskGroupJsonList = prefs.getStringList('taskGroups') ?? [];
  //   List<TaskGroup> taskGroups = taskGroupJsonList
  //       .map((taskGroupJson) => TaskGroup.fromJson(json.decode(taskGroupJson)))
  //       .toList();
  //   return taskGroups;
  // }

  // Future<void> saveProfileGroups(List<ProfileGroup> profileGroups) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> profileGroupJsonList = profileGroups
  //       .map((profileGroup) => json.encode(profileGroup.toJson()))
  //       .toList();
  //   await prefs.setStringList('profileGroups', profileGroupJsonList);
  // }

  // Future<List<ProfileGroup>> loadProfileGroups(SharedPreferences prefs) async {
  //   List<String> profileGroupJsonList =
  //       prefs.getStringList('profileGroups') ?? [];
  //   List<ProfileGroup> profileGroups = profileGroupJsonList
  //       .map((profileGroupJson) =>
  //           ProfileGroup.fromJson(json.decode(profileGroupJson)))
  //       .toList();
  //   return profileGroups;
  // }
