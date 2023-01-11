import 'package:flutter/material.dart';

class TasksInputs with ChangeNotifier{
  String taskproduct = "";
  String taskstore = "";
  String tasksize = "";
  String taskcategory = "";
  List<String> taskkeywords = [];
  int num_of_tasks = 0;
  String taskregion = "";
  String taskprofile = "";
  String tasktype = "";
  String taskgroup = "";
  


  String get product => taskproduct;
  String get task_size => tasksize;
  String get task_category => taskcategory;
  List<String> get keywords => taskkeywords;
  String get task_region => taskregion;
  String get task_profile => taskprofile;
  String get task_type => tasktype;
  String get task_group => taskgroup;
  String get task_store=> taskstore;
  int get tasks_num=> num_of_tasks;



  void setsize(String size){tasksize = size;}
  void setcategory(String category){taskcategory = category;}
  void setregion(String region){taskregion = region;}
  void setprofile(String profile){taskprofile = profile;}
  void settype(String type){tasktype = type;}
  void setgroup(String group){taskgroup = group;}
  void setstore(String store){taskstore = store;}
  void setproduct(String product){taskproduct = product;}
  void setNum_of_tasks(int num){num_of_tasks = num;}






}