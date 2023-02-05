import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:flutter/material.dart';

class TaskGroupList with ChangeNotifier{
  String taskgroup_name = "";
  String taskproduct = "";
  String taskstore = "";
  String tasksize = "";
  String taskcategory = "";
  List<String> taskkeywords = [];
  String taskregion = "";
  String taskprofile = "";
  String tasktype = "";
  late BuildContext context;
  List<Widget> group_list = [];

  List<Widget> get GroupList => group_list;

  void setContext(BuildContext newcontext){context = newcontext;}

  void setTaskProduct(String product){taskproduct = product;}
  void setTaskStore(String store){taskstore = store;}
  void setTaskSize(String size){tasksize = size;}
  void setTaskCategory(String category){}
  void setTaskKeywords(List<String> keywords){}
  void setTaskRegion(String region){}
  void setTaskProfile(String profile){taskprofile = profile;}
  void setTaskType(String taskType){}
 

  Widget createTaskGroup(context){
     return Container(
       child: TextButton( style: TextButton.styleFrom(
                   foregroundColor: Colors.white,
                   backgroundColor: Colors.blue,
                   minimumSize: Size(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.height* 0.1)
                   //padding: const EdgeInsets.all(16.0),
                  
              
        ),
        onPressed: (){},
        child: Row(
            children:  [
              const Spacer(),
              Text(taskgroup_name,style: const TextStyle(fontSize: 17),),
              Padding(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.006, 0, 0),
                child: Icon(Icons.add,size:MediaQuery.of(context).size.height * 0.027  ,),
              ),
              const Spacer(),
            ],
          ),
        ),
     );
  }

  void addToGroupList(context){
    group_list.add(createTaskGroup(context));
  }


 
  
}
