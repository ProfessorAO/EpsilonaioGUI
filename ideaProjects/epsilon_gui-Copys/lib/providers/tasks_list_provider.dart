import 'package:epsilon_gui/connection_to_bot/send_to_bot.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TasksLists with ChangeNotifier{

// VARIABLES
  List<int> id_list = [];
  List<DataRow> current_tasks_list = [];

// GETTERS
  int get count => current_tasks_list.length;
  List<DataRow> get tasks => current_tasks_list;

// ADDS TASKS TO THE TABLE
  void addTask(int numOfTasks,String storeData, String productData, String profileData){
    for(var i = 0;i<numOfTasks;i++){
      if(id_list.isEmpty == true){id_list.add(1);}
      else{id_list.add(id_list.last + 1);}
      current_tasks_list.add(createTaskCell(id_list.last, storeData, productData, profileData,'pending...',));
    }
    notifyListeners();
  }
//CREATES A ROW TO BE ADDED TO THE LIST
  DataRow createTaskCell(int Id, String store_, String product_, String profile_, String status_ ){
    return DataRow(cells: [
      DataCell(Text(Id.toString(),style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(store_,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(product_,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(profile_,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(status_,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Row(
            children: [
              InkWell(child: Icon(Icons.play_arrow,color: Colors.white,),
              onTap: (){
                print("Play pressed");
                 try{
                    sendToBot();
                  }on PlatformException catch(e){
                    print('error: ${e.details}');

                  }
                
                },),
              InkWell(child: Icon(Icons.pause,color: Colors.white),
              onTap: (){
                print("Pause pressed");
                
                },),
              InkWell(child: Icon(Icons.stop,color: Colors.white),
              onTap: (){
                print("Stop pressed");
                
                },),
            ],
          ),),
    ]);
  }
// REMOVES ALL THE TASKS FROM THE LIST
  void removeAllTasks(){
    current_tasks_list.clear();
    id_list.clear();
    notifyListeners();
  }



}