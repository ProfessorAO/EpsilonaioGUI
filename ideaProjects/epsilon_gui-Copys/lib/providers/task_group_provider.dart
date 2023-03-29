import 'dart:math';

import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskGroupList with ChangeNotifier {
  String taskgroup_name = "";
  int checkouts = 0;
  int fails = 0;
  List<TaskGroup> taskGroup_list = [];
  Map<UniqueKey, TaskGroup> taskGroupMap = {};
  Map<UniqueKey, Widget> taskGroupMap_widget = {};

  void setGroupName(String group_name) {
    taskgroup_name = group_name;
  }

  Widget createTaskGroup(
      BuildContext context,
      int tasknum,
      String taskstore,
      String taskproduct,
      String taskprofile,
      String taskSize,
      String groupName,
      UniqueKey key) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize:
                Size(double.infinity, MediaQuery.of(context).size.height * 0.08)
            //padding: const EdgeInsets.all(16.0),

            ),
        onPressed: () {
          final snackBar = SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: Text('$groupName Used'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<TasksLists>().removeAllTasks();
          context.read<TasksLists>().addTask(
              tasknum, taskstore, taskproduct, taskprofile, taskSize, context);
        },
        onLongPress: () {},
        child: Row(
          children: [
            Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 10,
                      color: Colors.black,
                      child: Text(
                        tasknum.toString(),
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: 25,
                      height: 10,
                      color: Colors.black,
                      child: Text(
                        checkouts.toString(),
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: 25,
                      height: 10,
                      color: Colors.black,
                      child: Text(
                        fails.toString(),
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  ],
                )),
            Spacer(),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  groupName,
                  style: const TextStyle(fontSize: 17),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        deleteAGroup(key);
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void deleteAGroup(UniqueKey uniqueKey) {
    taskGroupMap.removeWhere((key, value) => key == uniqueKey);
    taskGroupMap_widget.removeWhere((key, value) => key == uniqueKey);
    notifyListeners();
  }

  void addToGroupList(
      context,
      int tasknum,
      String taskstore,
      String taskproduct,
      String taskprofile,
      String taskSize,
      String groupName) {
    final UniqueKey key = UniqueKey();
    final thisTask = <UniqueKey, TaskGroup>{
      key: TaskGroup(
          groupName, taskproduct, taskprofile, taskstore, taskSize, tasknum)
    };

    final thisTaskWidget = <UniqueKey, Widget>{
      key: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color: Color.fromARGB(255, 25, 36, 78), width: 3)),
            child: createTaskGroup(context, tasknum, taskstore, taskproduct,
                taskprofile, taskSize, groupName, key),
          ),
        ],
      )
    };

    taskGroupMap_widget.addEntries(thisTaskWidget.entries);
    taskGroupMap.addEntries(thisTask.entries);
    notifyListeners();
  }
}

class TaskGroup {
  int tasknum;
  String store;
  String product;
  String profile;
  String size;
  String groupName;
  UniqueKey key = UniqueKey();

  TaskGroup(this.groupName, this.product, this.profile, this.store, this.size,
      this.tasknum);

  void setTaskNum(int newtaskNum) {
    tasknum = newtaskNum;
  }

  void setStore(String newStore) {
    store = newStore;
  }

  void setProduct(String newProduct) {
    product = newProduct;
  }

  void setSize(String newSize) {
    size = newSize;
  }

  void setGroupName(String newGroupName) {
    groupName = newGroupName;
  }
}
