import 'package:flutter/material.dart';

class ConsoleLogger with ChangeNotifier{
  List<String> logger = [];
  String output = "";



  List<String> get log => logger;


  void logOuput_createTask(String username){
    String time = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second},${DateTime.now().millisecond}" ;
    output = "$time INFO [$username] Task Created -  ";
    logger.add(output);
    notifyListeners();
  }
  String task_log(){
    String time = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second},${DateTime.now().millisecond}" ;

    return "$time Task Created at ";

  }




}