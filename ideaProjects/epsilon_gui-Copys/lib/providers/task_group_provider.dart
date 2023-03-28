import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskGroupList with ChangeNotifier {
  String taskgroup_name = "";
  String taskproduct = "";
  String taskstore = "";
  String tasksize = "";
  String taskcategory = "";
  List<String> taskkeywords = [];
  String taskregion = "";
  String taskprofile = "";
  String tasktype = "";
  int tasknum = 0;
  int checkouts = 0;
  int fails = 0;
  List<Widget> group_list = [];

  List<Widget> get GroupList => group_list;

  void setGroupName(String group_name) {
    taskgroup_name = group_name;
  }

  void setTaskProduct(String product) {
    taskproduct = product;
  }

  void setTaskStore(String store) {
    taskstore = store;
  }

  void setTaskSize(String size) {
    tasksize = size;
  }

  void setTaskCategory(String category) {}
  void setTaskKeywords(List<String> keywords) {}
  void setTaskRegion(String region) {}
  void setTaskProfile(String profile) {
    taskprofile = profile;
  }

  void setTaskType(String taskType) {}
  void setTaskNum(int user_tasknum) {
    tasknum = user_tasknum;
  }

  Widget createTaskGroup(BuildContext context) {
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
            content: Text('$taskgroup_name Used'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<TasksInputs>().setproduct(taskproduct);
          context.read<TasksInputs>().setsize(tasksize);
          context.read<TasksInputs>().setprofile(taskprofile);
          context.read<TasksInputs>().setstore(taskstore);
          context.read<TasksInputs>().setNum_of_tasks(tasknum);
          context.read<TasksLists>().removeAllTasks();
          context.read<TasksLists>().addTask(
              context.read<TasksInputs>().tasks_num,
              context.read<TasksInputs>().task_store,
              context.read<TasksInputs>().product,
              context.read<TasksInputs>().task_profile,
              context.read<TasksInputs>().task_size,
              context);
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
                  taskgroup_name,
                  style: const TextStyle(fontSize: 17),
                )),
          ],
        ),
      ),
    );
  }

  void addToGroupList(context) {
    //group_list.add(Spacer());
    group_list.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    ));
    group_list.add(
      Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border:
                Border.all(color: Color.fromARGB(255, 25, 36, 78), width: 3)),
        child: createTaskGroup(context),
      ),
    );
  }
}
