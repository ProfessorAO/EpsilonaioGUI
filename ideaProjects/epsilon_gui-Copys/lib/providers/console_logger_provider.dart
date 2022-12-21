import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ConsoleLogger with ChangeNotifier{
  List<String> logger = [];
  String output = "";



  List<String> get log => logger;


  void logOuput_createTask(String username){
    String time = (DateTime.now().year.toString())+"-" +DateTime.now().month.toString()+"-"  + DateTime.now().day.toString() + "  " + DateTime.now().hour.toString()+":"+ DateTime.now().minute.toString()+":"+  DateTime.now().second.toString() + "," +DateTime.now().millisecond.toString() ;
    output = "$time INFO [$username] Task Created -  ";
    logger.add(output);
    notifyListeners();
  }
  String task_log(){
    String time = (DateTime.now().year.toString())+"-" +DateTime.now().month.toString()+"-"  + DateTime.now().day.toString() + "  " + DateTime.now().hour.toString()+":"+ DateTime.now().minute.toString()+":"+  DateTime.now().second.toString() + "," +DateTime.now().millisecond.toString() ;

    return "$time Task Created at ";

  }




}