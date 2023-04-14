import 'dart:io';
import 'package:epsilon_gui/providers/recent_checkouts_provider.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:epsilon_gui/providers/user_data_provider.dart';
import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class Taskinstance with ChangeNotifier {
  int taskID = 0;
  String taskproduct = "";
  String taskstore = "";
  String tasksize = "";
  String taskcategory = "";
  List<String> taskkeywords = [];
  String taskregion = "";
  Profile taskprofile;
  String taskPrice = '';
  String tasktype = "";
  String taskstatus = "Ready";
  bool check = false;
  bool isactive = false;
  DataRow taskRow = DataRow(cells: []);
  TasksLists tasksList = TasksLists();
  int completed_int = 0;
  int failed_int = 0;
  bool tor = false;

  UserData data = UserData.instance;
  RecentCheckoutProvider recent_checkouts = RecentCheckoutProvider.instance;

  Taskinstance(this.taskID, this.taskproduct, this.taskstore, this.taskprofile,
      this.tasksize, this.taskkeywords, this.tor) {
    check = false;
    taskRow = DataRow(
        onLongPress: () {},
        onSelectChanged: ((value) {
          check = (value!);
          RedrawDataRow(getColor(taskstatus), check);
          tasksList.refreshData(getSelf());
          notifyListeners();
        }),
        selected: check,
        cells: [
          DataCell(Text(
            taskID.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskstore,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskproduct,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            tasksize,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskprofile.profileName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskstatus,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.green,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    startTask();
                  },
                  splashRadius: 15,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () {},
                  splashRadius: 15,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    deleteTask();
                  },
                  splashRadius: 15,
                ),
              ],
            ),
          ),
        ]);
  }
  DataRow get task_dataRow => taskRow;

  final _statusController = StreamController<String>();

  Stream<String> get statusStream => _statusController.stream;
  Map<String, dynamic> createTaskMap() {
    var taskMap = <String, dynamic>{
      'eventType': 'Task Creation',
      'product': taskproduct,
      'size': tasksize,
      'website': taskstore,
      'ID': taskID.toString(),
      'store': taskstore,
      'first_name': taskprofile.first_name,
      'last_name': taskprofile.last_name,
      'card_name': taskprofile.card_name,
      'card_number': taskprofile.card_number,
      'address': taskprofile.address,
      'city': taskprofile.city,
      'postcode': taskprofile.postcode,
      'phone': taskprofile.phone,
      'keywords': taskkeywords,
      'tor_used': tor,
    };
    return taskMap;
  }

  void setParent(TasksLists TL) {
    tasksList = TL;
  }

  void startTask() async {
    try {
      IOWebSocketChannel? channel;

      try {
        channel = IOWebSocketChannel.connect('ws://localhost:679');
        if (channel == null) {
          updateTask("Error");
          throw const SocketException("");
        }
      } catch (e) {
        print("Error on Connecting to server$e");
      }
      var map = jsonEncode(createTaskMap());
      channel?.sink.add(map);
      //channel?.sink.add(taskkeywords);

      isactive = true;
      channel?.stream.listen((event) {
        print(event);

        if (checkIfInt(event)) {
          taskPrice = event;
        } else {
          updateTask(event);
        }
      });
    } on SocketException catch (e) {
      print("Error on Connecting to server$e");
    } on PlatformException catch (e) {
      print('error: ${e.details}');
    }
  }

  void stopTask() {}
  void deleteTask() {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      content: const Text('Task Removed'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    tasksList.deleteTask(getSelf());
  }

  Color getColor(status) {
    Color col;
    if (status == 'Ready') {
      col = Colors.blue;
    } else if (status == 'Added To Cart') {
      col = Colors.blue;
    } else if (status == 'Checking out') {
      col = Colors.blue;
    } else if (status == 'Completed') {
      col = Colors.green;
      data.incrementCheckouts();
      data.addToTotalSpent(double.parse(taskPrice));
      completed_int += 1;
      recent_checkouts.createRecentCheckoutRow(taskPrice, taskproduct,
          taskstore, taskprofile.profileName, DateTime.now().toString());
      notifyListeners();
    } else if (status == 'Ready') {
      col = Colors.white;
    } else {
      col = Colors.red;
      if (failed_int == 0) {
        data.incrementFailures();
        failed_int += 1;
      }
    }
    return col;
  }

  bool checkIfInt(str) {
    num? number = num.tryParse(str);
    if (number != null) {
      return true;
    } else {
      return false;
    }
  }

  void updateTask(newstatus) {
    taskstatus = newstatus;
    RedrawDataRow(getColor(newstatus), check);
    tasksList.refreshData(getSelf());
    notifyListeners();
  }

  void RedrawDataRow(Color col, bool check) {
    taskRow = DataRow(
        onSelectChanged: ((value) {
          check = (value!);
          RedrawDataRow(getColor(taskstatus), check);
          tasksList.refreshData(getSelf());
          notifyListeners();
        }),
        selected: check,
        cells: [
          DataCell(Text(
            taskID.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskstore,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskproduct,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            tasksize,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskprofile.profileName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
          DataCell(Text(
            taskstatus,
            style: TextStyle(
              color: col,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  color: Colors.green,
                  onPressed: () {
                    startTask();
                  },
                  splashRadius: 15,
                ),
                IconButton(
                  icon: const Icon(Icons.pause),
                  color: Colors.white,
                  onPressed: () {},
                  splashRadius: 15,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    deleteTask();
                  },
                  splashRadius: 15,
                ),
              ],
            ),
          ),
        ]);
  }

  Taskinstance getSelf() {
    return this;
  }
  //CREATES A ROW TO BE ADDED TO THE LIST
}
