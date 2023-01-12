import 'package:epsilon_gui/providers/console_logger_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:provider/provider.dart';



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
        body: SafeArea(
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 140,
                child: const SideMenu(color: Color.fromARGB(255, 49, 47, 47)),
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children:[
                      const background(),
                      const EpsilonText(),
                      TopBar(),
                      Tasksbar(),
                      Console(),
                      create_button(tasks: tasks),
                      taskLists(taskinputs: tasks),
                      startAll_button(),
                      remove_all_button(),
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
class startAll_button extends StatelessWidget {
  const startAll_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      left: ((MediaQuery.of(context).size.width) * 0.3)+ (MediaQuery.of(context).size.width * 0.59) -100,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 20,fontFamily: 'Audiowide',
            color: Colors.white,),
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
      top: 55,
      left: ((MediaQuery.of(context).size.width) * 0.3)+ (MediaQuery.of(context).size.width * 0.59) -383,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 20,fontFamily: 'Audiowide',
            color: Colors.white,),
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
      top: 100,
      left: MediaQuery.of(context).size.width * 0.3+30,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.59) ,
        height: MediaQuery.of(context).size.height /1.27 ,
        child: RawScrollbar(
          thumbColor: Colors.white,
          radius: const Radius.circular(16),
          thickness: 7,
          child: SingleChildScrollView(
            primary: true,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: DataTable(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                headingRowColor:  MaterialStateColor.resolveWith((states) {return const Color.fromRGBO(26, 25, 25, 0.6);},),
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
      color: Colors.white60,
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
      left:10,
      top: MediaQuery.of(context).size.height /1.6 + 60,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 240,
        color: const Color.fromRGBO(26, 25, 25, 0.7),
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
          context.read<TasksLists>().addTask(context.read<TasksInputs>().tasks_num,
              context.read<TasksInputs>().task_store,
              context.read<TasksInputs>().product,
              context.read<TasksInputs>().task_profile,
              context.read<TasksInputs>().task_size,
              );
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
    context.read<TasksInputs>().setstore(dropdownstore);
    context.read<TasksInputs>().setprofile(dropdownprofile);
    context.read<TasksInputs>().setsize(dropdownsize);
    return Positioned(
      left: 10,
      top: 50,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height /1.6 ,
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Column(
              children: const [
               Align(
                 alignment: Alignment.centerLeft,
                  child: Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline: -10,
                    child: Text("Tasks",
                        style: TextStyle(fontSize: 20,
                          fontFamily: 'Audiowide',
                          color: Color.fromARGB(255, 15, 237, 120),
                    )
                ),
              ),
            ),
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
                      controller: myController,
                      onChanged: (String value){context.read<TasksInputs>().setproduct(value);},
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
                     onChanged: (String value){context.read<TasksInputs>().setNum_of_tasks(int.parse(value));},
                     )
                ),
                const Spacer(),
                // TASK NUMBER
                Expanded(
                    flex: 2,
                    child: columInputer_text(controller: numController,
                     onChanged: (String value){context.read<TasksInputs>().setNum_of_tasks(int.parse(value));},
                     )
                ),
                const Spacer(),
                // REGION
                Expanded(
                    flex: 2,
                    child: columnInput_Menu(value:dropdownregion,
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
  });

  final TextEditingController controller;
  final StringCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(26, 25, 25, 0.6),
      child: TextField(style:const TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 16) ,
          controller: controller,
          onChanged: onChanged ,
          decoration: const InputDecoration(
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
  });

  final String value;
  final StringVoidCallback onChanged;
  final List<DropdownMenuItem<String>>? Menuitems;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        filled: true,
        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
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
