import 'package:epsilon_gui/providers/console_logger_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'dart:io';



List<String> size_list = <String>['XS', 'S', 'M', 'L', 'XL'];
List<String> category_list = <String>['Sneakers', 'Jackets', 'Bottoms', 'Jumpers', 'T-Shirts'];
List<String> region_list = <String>['UK', 'US', 'EU'];
List<String> profile_list = <String>['profile1'];
List<String> taskType_list = <String>['Browser', 'Requests'];
List<String> taskGroup_list = <String>['group1'];
List<String> store_list = <String>['Trapstar','Palace-Clothing'];
typedef StringVoidCallback = void Function(String?);
typedef StringCallback = void Function(String);

class tasks_screen extends StatefulWidget{
  const tasks_screen({super.key});

  @override
  tasksScreen createState()=> tasksScreen();
}
class tasksScreen extends State<tasks_screen> {
  List<Widget> tasks = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 26, 59),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Stack(
                    children:[
                     // const background(),
                      //const EpsilonText(),
                      context.watch<TabbarIndex>().this_TopBar,
                      //Tasksbar(),
                      //Console(),
                      //create_button(tasks: tasks),
                      taskLists(taskinputs: tasks),
                      createTaskGroup(),
                      bottomBar(),
                      startAll_button(),
                      remove_all_button(),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.006,
                        right: MediaQuery.of(context).size.width *0.006,
                        child: Container(
                          child: Text("Version 1.0",style: TextStyle(color: Colors.white, fontFamily: "Audiowide",fontSize: 13),))),

                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.17,
                        child: TextButton(onPressed: (){
                            String product = "";
                            String dropdownsize = size_list.first ;
                            String dropdowncategory = category_list.first;
                            String dropdownregion = region_list.first;
                            String dropdownprofile = profile_list.first;
                            String dropdownTT = taskType_list.first;
                            String dropdownTG = taskGroup_list.first;
                            String dropdownstore = store_list.first;
                            final myController = TextEditingController();
                            final numController = TextEditingController();
                            final keywordsController = TextEditingController();
                                                    showPopupWindow(
                             context,
  gravity: KumiPopupGravity.center,
  //curve: Curves.elasticOut,
  bgColor: Color.fromARGB(255, 17, 26, 59).withOpacity(0.8),
  clickOutDismiss: true,
  clickBackDismiss: true,
  customAnimation: false,
  customPop: false,
  customPage: false,
  //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
  //needSafeDisplay: true,
  underStatusBar: false,
  underAppBar: true,
  offsetX: 0,
  offsetY: 0,
  duration: Duration(milliseconds: 200),
  childFun: (pop) {
    return Container(
      key: GlobalKey(),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.45,
      color: Color.fromARGB(255, 25, 36, 78),
      child: Row(
        children: [

          
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: columInputer_text(
                      controller: myController,
                      onChanged: (String value){product = value;},
                      label: "Product",
                      
                     )
                ),
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(Menuitems:const [
                        DropdownMenuItem(value: "Trapstar",child: Text("Trapstar"),),
                        DropdownMenuItem(value: "Palace-Clothing",child: Text("Palace-Clothing"),),
                      ] ,
                      value: dropdownstore,
                      label: "Store",
                      onChanged: (String? value) {setState(() {
                      dropdownstore = value!;
                      
                      
                    });  },
                    )
                ),
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value: dropdownsize,
                    label: "Size",
                    Menuitems: const [
                            DropdownMenuItem(value: "XS",child: Text("XS"),),
                            DropdownMenuItem(value: "S",child: Text("S"),),
                            DropdownMenuItem(value: "M",child: Text("M"),),
                            DropdownMenuItem(value: "L",child: Text("L"),),
                            DropdownMenuItem(value: "XL",child: Text("XL"),),
                            ],
                            
                     onChanged:(String? value) {setState(() {
                      dropdownsize = value!;
                         
                      
                      
                    });  }, )
                ),
                const Spacer(),
                //CATEGORY
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdowncategory,
                    label: "Clothing Category",
                    Menuitems:const [
                        DropdownMenuItem(value: "Sneakers",child: Text("Sneakers"),),
                        DropdownMenuItem(value: "Jackets",child: Text("Jackets"),),
                        DropdownMenuItem(value: "Bottoms",child: Text("Bottoms"),),
                        DropdownMenuItem(value: "Jumpers",child: Text("Jumpers"),),
                        DropdownMenuItem(value: "Shirts",child: Text("T-Shirts"),),
                      ], 
                      onChanged:  (String? value) {setState(() {
                      dropdowncategory = value!;
                    });  },
                    )                 
                ),
                //COLOR
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: columInputer_text(controller: keywordsController,
                    label:"Color" ,
                     onChanged: (String value){context.read<TasksInputs>().setNum_of_tasks(int.parse(value));},
                     )
                ),
                const Spacer(),
                // TASK NUMBER
                Expanded(
                    flex: 2,
                    child: columInputer_text(controller: numController,
                    label: "Number of Tasks",
                     onChanged: (String value){context.read<TasksInputs>().setNum_of_tasks(int.parse(value));},
                     )
                ),
                const Spacer(),
                // REGION
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownregion,
                    label: "Region",
                    Menuitems:const [
                        DropdownMenuItem(value: "UK",child: Text("UK"),),
                        DropdownMenuItem(value: "US",child: Text("US"),),
                        DropdownMenuItem(value: "EU",child: Text("EU"),),
                      ], 
                      onChanged:  (String? value) {setState(() {
                      dropdownregion = value!;
                    });  },
                    )
                ),
                const Spacer(),
                //PROFILE
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownprofile,
                    label: "Profile",
                    Menuitems:const [
                        DropdownMenuItem(value: "profile1",child: Text("profile1"),),
                      ],
                      onChanged:  (String? value) {setState(() {
                      dropdownprofile = value!;
                      
                    });  },
                    )
                ),
                const Spacer(),
                //TASK TYPE
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownTT,
                    label: "Task Type",
                    Menuitems:const [
                        DropdownMenuItem(value: "Browser",child: Text("Browser"),),
                        DropdownMenuItem(value: "Requests",child: Text("Requests"),),
                      ],
                      onChanged:  (String? value) {setState(() {
                      dropdownTT = value!;
                    });  },
                    )                    
                ),
                const Spacer(),
                //TASK GROUP
                Expanded(
                    flex: 2,
                    child:columnInput_Menu(value:dropdownTG,
                    label: "Proxy Group",
                    Menuitems:const [
                       DropdownMenuItem(value: "group1",child: Text("group1"),),
                      ],
                      onChanged:  (String? value) {setState(() {
                      dropdownTG = value!;
                    });  },
                    )
                ),
              ],

            ),
          ),
           Expanded(child:TextButton(
            onPressed: (){
              final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: const Text('Task Created'),
                    action: SnackBarAction(
                    label: '',
              onPressed: () {},
            ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
              context.read<TasksInputs>().setstore(dropdownstore);
              context.read<TasksInputs>().setprofile(dropdownprofile);
              context.read<TasksInputs>().setsize(dropdownsize);
              context.read<TasksInputs>().setproduct(product);
              context.read<TasksLists>().addTask(context.read<TasksInputs>().tasks_num,
              context.read<TasksInputs>().task_store,
              context.read<TasksInputs>().product,
              context.read<TasksInputs>().task_profile,
              context.read<TasksInputs>().task_size,
              );
              
            },
            style:TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        
                          textStyle: const TextStyle(fontSize: 20,
                          color: Colors.white,),),
            child: Text("Save"))
      )
      ]
      )
    );
  },

                          );


                        },style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(
                          color: Colors.white,),),
                           child: const Text("Create task") ),
                      ),
                     
                    ],
                  ),
                ),
              ),
              
              ],
              
          ),
        )
    );
  }
}

class createTaskGroup extends StatelessWidget {
  const createTaskGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.72,
      top: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        children: [
          Container(color: Colors.white, height: MediaQuery.of(context).size.height * 0.1,),
          Container(
            decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color.fromARGB(255, 17, 26, 59),
                          border:  Border.all(color: Color.fromARGB(255, 25, 36, 78),width: 3.5)
            ),
            
            width: MediaQuery.of(context).size.width * 0.265,
            height: MediaQuery.of(context).size.height * 0.77,
            
    
          ),
        ]
      ),
    );
  }
}

class bottomBar extends StatelessWidget {
  const bottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
     bottom: MediaQuery.of(context).size.height * 0.0001,
     child: Container(
                   color: Color.fromARGB(255, 25, 36, 78),
                   width: MediaQuery.of(context).size.width * 1,
                   height: MediaQuery.of(context).size.height * 0.065,
                   
                   
                      
                 ),
                      );
  }
}
class startAll_button extends StatelessWidget {
  const startAll_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.1 ,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(16.0),
          
        ),
        onPressed: () {
          context.read<TasksLists>().startAllTasks();
          },
        child: const Text('Start All'),
      ),
    );
  }
}
class remove_all_button extends StatelessWidget {
  const remove_all_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.height * 0.03,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {context.read<TasksLists>().removeAllTasks();
        },
        child: const Text('Remove all'),
      ),
    );
  }
}
class taskLists extends StatefulWidget {
  taskLists({
    super.key,
    required this.taskinputs,
  });

  final List<Widget> taskinputs;

  @override
  State<taskLists> createState() => _taskListsState();
}
class _taskListsState extends State<taskLists> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height *0.08,
      left: MediaQuery.of(context).size.width * 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7 ,
        height: MediaQuery.of(context).size.height * 0.84 ,
        child: RawScrollbar(
          thumbColor: Colors.white,
          radius: const Radius.circular(16),
          thickness: 3,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            dragStartBehavior: DragStartBehavior.down,
            primary: true,
            child: Theme(
              data: ThemeData(
                primarySwatch: Colors.blue,
                  unselectedWidgetColor: Colors.white,
              ),

              child: DataTable(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                
                headingRowColor:  MaterialStateColor.resolveWith((states) {return const Color.fromARGB(255, 25, 36, 78) ;},),
                columns: const [
                  DataColumn(label: taskColumn(name:"ID"),
                  ),
                  DataColumn(label: taskColumn(name:"Store")
                  ),
                  DataColumn(label: taskColumn(name:"Product")
                  ),
                  DataColumn(label: taskColumn(name:"Profile")
                  ),
                  DataColumn(label:taskColumn(name:"Status")
                  ),
                  DataColumn(label:taskColumn(name:"Actions")
                  ),
                ],
                rows: context.watch<TasksLists>().tasks_data,
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class taskColumn extends StatelessWidget {
  const taskColumn({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name,style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Audiowide',
      fontSize: 15,
    ),);
  }
}
class Console extends StatelessWidget {
  const Console({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left:MediaQuery.of(context).size.width*0.01,
      bottom: MediaQuery.of(context).size.height *0.02,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        color: const Color.fromARGB(255, 25, 36, 78) ,
        child: Align(
          alignment: Alignment.topLeft,
          child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children:
                [for (var text in context.watch<ConsoleLogger>().log) Text(text,style: const TextStyle(color: Colors.white))],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
class create_button extends StatefulWidget {
  const create_button({
    super.key, required this.tasks,
  });
  final List<Widget> tasks;
  @override
  State<create_button> createState() => _create_buttonState();
}
class _create_buttonState extends State<create_button> {

   
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:55,
      left: ((MediaQuery.of(context).size.width) * 0.3)+ (MediaQuery.of(context).size.width * 0.59) -220,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 20,fontFamily: 'Audiowide',
            color: Colors.white,),
        ),
        onPressed: () async{
          
          context.read<ConsoleLogger>().logOuput_createTask("User 1");
          },
        child: const Text('Create'),
      ),
    );
  }
}
class Tasksbar extends StatefulWidget{
  const Tasksbar({super.key});

  @override
  Task_inputs createState()=> Task_inputs();


}
class Task_inputs extends State<Tasksbar> {
  String dropdownsize = size_list.first ;
  String dropdowncategory = category_list.first;
  String dropdownregion = region_list.first;
  String dropdownprofile = profile_list.first;
  String dropdownTT = taskType_list.first;
  String dropdownTG = taskGroup_list.first;
  String dropdownstore = store_list.first;


  final myController = TextEditingController();
  final numController = TextEditingController();
  final keywordsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.0001,
      top: MediaQuery.of(context).size.height * 0.07,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.6 ,
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Column(
              children: const [

                Expanded(
                    flex: 2,
                    child: taskInputData(name: "Product")
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                     child: taskInputData(name: "Website")
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                   child: taskInputData(name: "Size")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: taskInputData(name: "Category")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                     child: taskInputData(name: "Keywords")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                     child: taskInputData(name: "No. Of Tasks")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                     child: taskInputData(name: "Region")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                     child: taskInputData(name: "Profile")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: taskInputData(name: "Task Type")
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                     child: taskInputData(name: "Proxy Group")
                ),
                          ],
                        ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: columInputer_text(
                      label: "",
                      controller: myController,
                      onChanged: (String value){context.read<TasksInputs>().setproduct(value);},
                     )
                ),
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(label: "",Menuitems:const [
                        DropdownMenuItem(value: "Trapstar",child: Text("Trapstar"),),
                        DropdownMenuItem(value: "Palace-Clothing",child: Text("Palace-Clothing"),),
                      ] ,
                      value: dropdownstore,
                      onChanged: (String? value) {setState(() {
                      dropdownstore = value!;
                      context.read<TasksInputs>().setstore(dropdownstore);
                      
                    });  },
                    )
                ),
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value: dropdownsize,
                    label: "",
                    Menuitems: const [
                            DropdownMenuItem(value: "XS",child: Text("XS"),),
                            DropdownMenuItem(value: "S",child: Text("S"),),
                            DropdownMenuItem(value: "M",child: Text("M"),),
                            DropdownMenuItem(value: "L",child: Text("L"),),
                            DropdownMenuItem(value: "XL",child: Text("XL"),),
                            ],
                     onChanged:(String? value) {setState(() {
                      dropdownsize = value!;
                      context.read<TasksInputs>().setsize(dropdownsize);
                    });  }, )
                ),
                const Spacer(),
                //CATEGORY
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdowncategory,
                    label: "",
                    Menuitems:const [
                        DropdownMenuItem(value: "Sneakers",child: Text("Sneakers"),),
                        DropdownMenuItem(value: "Jackets",child: Text("Jackets"),),
                        DropdownMenuItem(value: "Bottoms",child: Text("Bottoms"),),
                        DropdownMenuItem(value: "Jumpers",child: Text("Jumpers"),),
                        DropdownMenuItem(value: "Shirts",child: Text("T-Shirts"),),
                      ], 
                      onChanged:  (String? value) {setState(() {
                      dropdowncategory = value!;
                    });  },
                    )                 
                ),
                //COLOR
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: columInputer_text(controller: keywordsController,
                    label: "",
                     onChanged: (String value){context.read<TasksInputs>().setNum_of_tasks(int.parse(value));},
                     )
                ),
                const Spacer(),
                // TASK NUMBER
                Expanded(
                    flex: 2,
                    child: columInputer_text(controller: numController,
                    label: "",
                     onChanged: (String value){context.read<TasksInputs>().setNum_of_tasks(int.parse(value));},
                     )
                ),
                const Spacer(),
                // REGION
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownregion,
                    label: "",
                    Menuitems:const [
                        DropdownMenuItem(value: "UK",child: Text("UK"),),
                        DropdownMenuItem(value: "US",child: Text("US"),),
                        DropdownMenuItem(value: "EU",child: Text("EU"),),
                      ], 
                      onChanged:  (String? value) {setState(() {
                      dropdownregion = value!;
                    });  },
                    )
                ),
                const Spacer(),
                //PROFILE
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownprofile,
                    label: "",
                    Menuitems:const [
                        DropdownMenuItem(value: "profile1",child: Text("profile1"),),
                      ],
                      onChanged:  (String? value) {setState(() {
                      dropdownprofile = value!;
                      context.read<TasksInputs>().setprofile(dropdownprofile);
                    });  },
                    )
                ),
                const Spacer(),
                //TASK TYPE
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownTT,
                    label: "",
                    Menuitems:const [
                        DropdownMenuItem(value: "Browser",child: Text("Browser"),),
                        DropdownMenuItem(value: "Requests",child: Text("Requests"),),
                      ],
                      onChanged:  (String? value) {setState(() {
                      dropdownTT = value!;
                    });  },
                    )                    
                ),
                const Spacer(),
                //TASK GROUP
                Expanded(
                    flex: 2,
                    child:columnInput_Menu(value:dropdownTG,
                    label: "",
                    Menuitems:const [
                       DropdownMenuItem(value: "group1",child: Text("group1"),),
                      ],
                      onChanged:  (String? value) {setState(() {
                      dropdownTG = value!;
                    });  },
                    )
                ),
              ],

            ),
          )
        ],
      ),
    ),
              );
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
class columInputer_text extends StatelessWidget {
  const columInputer_text({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.label,
  });

  final TextEditingController controller;
  final StringCallback onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 25, 36, 78) ,
      child: TextField(style:const TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 16) ,
          controller: controller,
          onChanged: onChanged ,
          decoration: InputDecoration(
            label: Text(label,style: TextStyle(color: Colors.white70,fontSize: 15),),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.all(8),
          )
      ),

    );
  }
}
class columnInput_Menu extends StatelessWidget {
  const columnInput_Menu({
    super.key,
    required this.value,
    required this.onChanged,
    required this.Menuitems,
    required this.label,
  });

  final String value;
  final StringVoidCallback onChanged;
  final List<DropdownMenuItem<String>>? Menuitems;
  final String label;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        label: Text(label,style: TextStyle(color: Colors.white70,fontSize: 15),),
        filled: true,
        fillColor:  Color.fromARGB(255, 25, 36, 78) ,
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(8),
      ),
      dropdownColor: const Color.fromRGBO(26, 25, 25, 1),
      value: value,
        icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
      style:const TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

      items: Menuitems,
      onChanged: onChanged
      


    );
  }
}
class taskInputData extends StatelessWidget {
  const taskInputData({
    super.key,
    required this.name
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(name,
            style: const TextStyle(fontSize: 15,
              fontFamily: 'Audiowide',
              color: Color.fromARGB(255, 15, 237, 120),
            )
        ),
      ),

    );
  }
}
