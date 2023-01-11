
import 'package:epsilon_gui/connection_to_bot/send_to_bot.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:epsilon_gui/providers/task_instance_provider.dart';
import 'package:epsilon_gui/screens/taskScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class TasksLists with ChangeNotifier{

// VARIABLES
  List<int> id_list = [];
  List<Taskinstance> tasks_instances = [];
  List<DataRow> current_tasks_list = [];
  List<String> all_task_status = [];
  late BuildContext context_ ;
  //TasksInputs current_inputs = TasksInputs();

// GETTERS
  int get count => current_tasks_list.length;
  List<DataRow> get tasks_data => current_tasks_list;
   List<Taskinstance> get tasks=> tasks_instances;
  List<String> get allStatus=> all_task_status;


  //SETTERS

  void RefreshData(Taskinstance task_){
    current_tasks_list[task_.taskID-1] = task_.taskRow;
    notifyListeners();
  }
  
// ADDS TASKS TO THE TABLE
  void addTask(int numOfTasks,String storeData, String productData, String profileData,String sizeData){
    
    for(var i = 0;i<numOfTasks;i++){
      if(id_list.isEmpty == true){
        id_list.add(1);
         Taskinstance task = Taskinstance(1, productData, storeData, profileData,sizeData);
         tasks_instances.add(task);
         current_tasks_list.add(task.taskRow);
        }
      else{
        id_list.add(id_list.last + 1);
        Taskinstance task = Taskinstance(id_list.last, productData, storeData, profileData,sizeData);
        tasks_instances.add(task);
        current_tasks_list.add(task.taskRow);
        
        }
        tasks_instances.forEach((task) {
          task.setParent(getSelf());
         });
      
    }
    notifyListeners();
  }
  void startAllTasks(){
    tasks_instances.forEach((task) {
      task.startTask();
     });
  }
//CREATES A ROW TO BE ADDED TO THE LIST
 
// REMOVES ALL THE TASKS FROM THE LIST
  void removeAllTasks(){
    current_tasks_list.clear();
    id_list.clear();
    tasks_instances.clear();
    notifyListeners();
  }

  TasksLists getSelf(){
    return this;
  }



  



}