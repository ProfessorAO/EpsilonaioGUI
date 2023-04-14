import 'dart:math';

import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/user_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskGroupList with ChangeNotifier {
  static final TaskGroupList _instance = TaskGroupList._internal();
  TaskGroupList._internal();
  List<TaskGroup> taskGroup_list = [];

  static TaskGroupList get instance => _instance;
  List<TaskGroup> get taskGroups => taskGroup_list;

  void deleteAGroup(UniqueKey uniqueKey) {
    taskGroup_list.removeWhere(
      (element) {
        return element.key == uniqueKey;
      },
    );
    notifyListeners();
  }

  List<Widget> getWidgets() {
    var widgetList = <Widget>[];
    for (TaskGroup tg in taskGroup_list) {
      widgetList.add(tg.widget);
    }
    return widgetList;
  }

  void addToGroupList(
      context,
      int tasknum,
      String taskstore,
      String taskproduct,
      ProfileGroup taskprofile,
      String taskSize,
      String groupName,
      List<String> taskkeywords,
      String taskOption) {
    final UniqueKey key = UniqueKey();

    TaskGroup thisTaskGroup = TaskGroup(groupName, taskproduct, taskprofile,
        taskstore, taskSize, tasknum, key, taskkeywords, taskOption);

    taskGroup_list.add(thisTaskGroup);
    //UserData.instance.saveTaskGroups(taskGroup_list);
    notifyListeners();
  }
}

class TaskGroupWidget extends StatelessWidget {
  final String groupName;
  final int tasknum;
  final UniqueKey uniqueKey;
  final String taskstore;
  final String taskproduct;
  final ProfileGroup taskprofile;
  final String tasksize;
  final List<String> keywords;
  final String taskOption;
  const TaskGroupWidget(
      {super.key,
      required this.groupName,
      required this.tasknum,
      required this.uniqueKey,
      required this.taskstore,
      required this.taskproduct,
      required this.taskprofile,
      required this.keywords,
      required this.tasksize,
      required this.taskOption});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border:
                  Border.all(color: Color.fromARGB(255, 25, 36, 78), width: 3)),
          child: Container(
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.08)
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
                bool tor;
                if (taskOption == "Browser") {
                  tor = false;
                } else {
                  tor = true;
                }
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                context.read<TasksLists>().removeAllTasks();
                context.read<TasksLists>().addTask(tasknum, taskstore,
                    taskproduct, taskprofile, tasksize, keywords, tor);
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
                              0.toString(),
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
                              0.toString(),
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
                              final snackBar = SnackBar(
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text("$groupName Deleted"),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              context
                                  .read<TaskGroupList>()
                                  .deleteAGroup(uniqueKey);
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
          ),
        ),
      ],
    );
  }
}

class TaskGroup {
  int tasknum;
  String store;
  String product;
  ProfileGroup profile;
  String size;
  String groupName;
  List<String> taskkeywords;
  TaskGroupWidget widget = TaskGroupWidget(
    groupName: "",
    tasknum: 0,
    uniqueKey: UniqueKey(),
    taskstore: "",
    taskproduct: "",
    taskprofile: ProfileGroup(UniqueKey(), "", []),
    tasksize: "",
    keywords: [],
    taskOption: "",
  );
  UniqueKey key;
  int checkouts = 0;
  int fails = 0;
  String option = "";

  TaskGroup(this.groupName, this.product, this.profile, this.store, this.size,
      this.tasknum, this.key, this.taskkeywords, this.option) {
    widget = TaskGroupWidget(
      groupName: groupName,
      tasknum: tasknum,
      uniqueKey: key,
      taskstore: store,
      taskproduct: product,
      taskprofile: profile,
      tasksize: size,
      keywords: [],
      taskOption: option,
    );
  }

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

  // Map<String, dynamic> toJson() {
  //   return {
  //     'tasknum': tasknum,
  //     'store': store,
  //     'product': product,
  //     'profile': profile.toJson(), // assuming ProfileGroup has toJson method
  //     'size': size,
  //     'groupName': groupName,
  //     'key': key.toString(),
  //   };
  // }

  // // Add fromJson method
  // factory TaskGroup.fromJson(Map<String, dynamic> json) {
  //   return TaskGroup(
  //     json['groupName'],
  //     json['product'],
  //     ProfileGroup.fromJson(
  //         json['profile']), // assuming ProfileGroup has fromJson method
  //     json['store'],
  //     json['size'],
  //     json['tasknum'],
  //     Container(), // widget will be recreated later
  //     UniqueKey.fromString(
  //         json['key']), // assuming UniqueKey has fromString method
  //   );
  // }
}
