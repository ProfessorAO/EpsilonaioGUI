import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';



class Taskinstance with ChangeNotifier{
  int taskID = 0;
  String taskproduct = "";
  String taskstore = "";
  String tasksize = "";
  String taskcategory = "";
  List<String> taskkeywords = [];
  String taskregion = "";
  String taskprofile = "";
  String tasktype = "";
  String taskgroup = "";
  String taskstatus = "Ready";
  bool isactive = false;
  DataRow taskRow = DataRow(cells: []);
  TasksLists tasksList = TasksLists();

  


   Taskinstance(id,product,store,profile,size){
    taskID = id;
    taskproduct = product;
    taskprofile =profile;
    tasksize =size ;
    taskstore = store;
    late bool check ;
    taskRow = DataRow(onSelectChanged:((value) {
      check = value!;

      
    }) ,selected: check, cells: [
      DataCell(Text(taskID.toString(),style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskstore,style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskproduct,style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskprofile,style:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskstatus,style:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Row(
            children: [
              IconButton(icon:const Icon(Icons.play_arrow),color: Colors.white,onPressed: () {startTask();},splashRadius: 15,),
              IconButton(icon:const Icon(Icons.pause),color: Colors.white,onPressed: () {},splashRadius: 15,),
              IconButton(icon:const Icon(Icons.stop),color: Colors.white,onPressed: () {} ,splashRadius: 15,),
            ],
          ),),
    ]
    
    );
   }
   DataRow get task_dataRow=> taskRow;

  final _statusController = StreamController<String>();

  Stream<String> get statusStream => _statusController.stream;
 Map<String,String> createTaskMap(){
    var taskMap = <String, String>{
      'product': taskproduct,
      'size': tasksize,
      'website': taskstore,
      };
      return taskMap;
      
    
   }

  void setParent(TasksLists TL){
      tasksList= TL ;
  }

   void startTask() async{
    try{
     IOWebSocketChannel? channel;
    try{
      channel = IOWebSocketChannel.connect('ws://localhost:679');
    }catch (e){
      print("Error on Connecting to server$e");
    }
    var map = jsonEncode(createTaskMap());
    channel?.sink.add(map);
    //channel?.sink.add(taskkeywords);


    
    this.isactive = true;
    channel?.stream.listen((event){
      print(event);
      updateStatus(event);
    });

  }on PlatformException catch(e){
    print('error: ${e.details}');
  }

   }
   void stopTask(){

   }
  
   Color getColor(status){
     Color col;
    if (status == 'Entering Site'){
      col = Colors.blue;
    }else if(status == 'Adding To Cart'){
      col = Colors.blue;
    }else if (status == 'Checking out'){
      col = Colors.blue;
    }else if (status == 'Completed'){
      col = Colors.green;
    }else{
      col = Colors.red;
    }
    return col ;

   }
   void updateStatus(newstatus){
    taskstatus = newstatus;
    RedrawDataRow(getColor(newstatus));
    tasksList.RefreshData(getSelf());
    notifyListeners();
   }
   void RedrawDataRow(Color col){
    taskRow = DataRow(cells: [
      DataCell(Text(taskID.toString(),style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskstore,style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskproduct,style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskprofile,style:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),)),
      DataCell(Text(taskstatus,style:TextStyle(
        color: col,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),)),
      DataCell(Row(
            children: [
              IconButton(icon:const Icon(Icons.play_arrow),color: Colors.white,onPressed: () {startTask();},splashRadius: 15,),
              IconButton(icon:const Icon(Icons.pause),color: Colors.white,onPressed: () {},splashRadius: 15,),
              IconButton(icon:const Icon(Icons.stop),color: Colors.white,onPressed: () {} ,splashRadius: 15,),
            ],
          ),),
    ]
    );

   }
   Taskinstance getSelf(){
    return this;
  }
   //CREATES A ROW TO BE ADDED TO THE LIST
   
    
    
  

}