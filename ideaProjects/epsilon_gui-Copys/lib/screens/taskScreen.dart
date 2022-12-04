import 'package:flutter/cupertino.dart';
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';

const List<String> size_list = <String>['XS', 'S', 'M', 'L', 'XL'];
const List<String> category_list = <String>['Sneakers', 'Jackets', 'Bottoms', 'Jumpers', 'T-Shirts'];
const List<String> region_list = <String>['UK', 'US', 'EU'];
const List<String> profile_list = <String>['profile1'];
const List<String> taskType_list = <String>['Browser', 'Requests'];
const List<String> taskGroup_list = <String>['group1'];
const List<String> store_list = <String>['Trapstar','Palace-Clothing'];

class tasks_screen extends StatefulWidget{
  const tasks_screen({super.key});

  @override
  tasksScreen createState()=> tasksScreen();
}
class tasksScreen extends State<tasks_screen> {
  List<Widget> taskinputs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 140,
                child: SideMenu(color: Color.fromARGB(255, 49, 47, 47)),
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children:[
                      background(),
                      EpsilonText(),
                      TopBar(),
                      Tasksbar(),
                      create_button(taskinputs: taskinputs),
                      Console(),
                      columnHeadings(),
                      taskLists(taskinputs: taskinputs),
                      startAll_button(),
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
          print("Start all button Pressed");
          },
        child: const Text('Start All'),
      ),
    );
  }
}
class taskLists extends StatefulWidget {
  const taskLists({
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
      top: 155,
      left: MediaQuery.of(context).size.width * 0.3+30,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.7) ,
        height: MediaQuery.of(context).size.height /1.27 ,
        child: SingleChildScrollView(
          child: Column(
            children: widget.taskinputs,
          ),
        ),
      ),
    );
  }
}
class a_task extends StatelessWidget {
  const a_task({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.7) ,
      height: MediaQuery.of(context).size.height /15,
      color: Colors.white60,
    );
  }
}
class columnHeadings extends StatelessWidget {
  const columnHeadings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
        left: MediaQuery.of(context).size.width * 0.3+30,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.59,
          height: 50,
          color: Color.fromRGBO(26, 25, 25, 0.6),
          child: Column(
            children: [
          Expanded(
            flex: 8,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text("ID",
                      style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Audiowide',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text("Website",
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Audiowide',
                      fontSize: 18,
                    ),
                  ),
                  Text("Item",
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Audiowide',
                      fontSize: 18,
                    ),
                  ),
                  Text("Profile",
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Audiowide',
                      fontSize: 18,
                    ),
                  ),
                  Text("Status",
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Audiowide',
                      fontSize: 18,
                    ),
                  ),
                  Text("Actions",
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Audiowide',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          ],

        ),
    ),
                    );
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
      top: MediaQuery.of(context).size.height /1.6 + 95,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 210,
        color: Color.fromRGBO(26, 25, 25, 0.7),
        child: Text("CONSOLE",style: TextStyle(fontSize: 15,
          fontFamily: 'Audiowide',
          color: Colors.white,
        ),),

      ),
    );
  }
}
class create_button extends StatefulWidget {
  const create_button({
    super.key, required this.taskinputs,
  });
  final List<Widget> taskinputs;

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
        onPressed: () {
          setState(() {
            widget.taskinputs.add(const a_task());
          });
          print("Create button Pressed");},
        child: const Text('Create'),
      ),
    );
  }
}
class Tasksbar extends StatefulWidget{
  Task_inputs createState()=> Task_inputs();


}
class Task_inputs extends State<Tasksbar> {
  String dropdownsize = size_list.first;
  String dropdowncategory = category_list.first;
  String dropdownregion = region_list.first;
  String dropdownprofile = profile_list.first;
  String dropdownTT = taskType_list.first;
  String dropdownTG = taskGroup_list.first;
  String dropdownstore = store_list.first;

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 50,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height /1.6 ,
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Column(
              children: [
               Align(
                 alignment: Alignment.centerLeft,
                  child: Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline: -10,
                    child: Text("Tasks",
                        style: TextStyle(fontSize: 25,
                          fontFamily: 'Audiowide',
                          color: Color.fromARGB(255, 15, 237, 120),
                    )
                ),
              ),
            ),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Product",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),

                    )
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Website",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),

                )
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Size",
                          style: TextStyle(fontSize: 20,
                            fontFamily: 'Audiowide',
                            color: Color.fromARGB(255, 15, 237, 120),
                          )
                      ),
                    ),


                  ),
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment:Alignment.center ,
                        child: Text("Category",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),


                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Keywords",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("No. Of Tasks",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),


                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Region",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Profile",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),


                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Task Type",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),


                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Proxy Group",
                            style: TextStyle(fontSize: 20,
                              fontFamily: 'Audiowide',
                              color: Color.fromARGB(255, 15, 237, 120),
                            )
                        ),
                      ),


                    )
                ),
                          ],
                        ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // anything directly underneath a expaneded widget must take the whole size but if it is another widget that comes it with its own size it may work
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: Container(
                        constraints:BoxConstraints(
                          maxHeight: 5,
                        ) ,
                        color: Color.fromRGBO(26, 25, 25, 0.6),
                        child: TextField(style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 17) ,
                            controller: myController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),

                              )
                        ),

                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdownstore,
                      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

                      items: const [
                        DropdownMenuItem(child: Text("Trapstar"),value: "Trapstar",),
                        DropdownMenuItem(child: Text("Palace-Clothing"),value: "Palace-Clothing",),
                      ], onChanged: (String? value) {setState(() {
                      dropdownstore = value!;
                    });  },


                    )
                ),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdownsize,
                        icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

                      items: const [
                      DropdownMenuItem(child: Text("XS"),value: "XS",),
                      DropdownMenuItem(child: Text("S"),value: "S",),
                        DropdownMenuItem(child: Text("M"),value: "M",),
                        DropdownMenuItem(child: Text("L"),value: "L",),
                        DropdownMenuItem(child: Text("XL"),value: "XL",),
                      ], onChanged: (String? value) {setState(() {
                      dropdownsize = value!;
                    });  },


                    )
                ),
                Spacer(),
                //CATEGORY
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdowncategory,
                      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

                      items: const [
                        DropdownMenuItem(child: Text("Sneakers"),value: "Sneakers",),
                        DropdownMenuItem(child: Text("Jackets"),value: "Jackets",),
                        DropdownMenuItem(child: Text("Bottoms"),value: "Bottoms",),
                        DropdownMenuItem(child: Text("Jumpers"),value: "Jumpers",),
                        DropdownMenuItem(child: Text("T-Shirts"),value: "Shirts",),
                      ], onChanged: (String? value) {setState(() {
                      dropdowncategory = value!;
                    });  },


                    )
                ),
                //COLOR
                Spacer(),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      child: TextField(style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 17) ,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                          )
                      ),

                    )
                ),
                Spacer(),
                // TASK NUMBER
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      child: TextField(style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 17) ,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                          )
                      ),

                    )
                ),
                Spacer(),
                // REGION
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdownregion,
                      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

                      items: const [
                        DropdownMenuItem(child: Text("UK"),value: "UK",),
                        DropdownMenuItem(child: Text("US"),value: "US",),
                        DropdownMenuItem(child: Text("EU"),value: "EU",),
                      ], onChanged: (String? value) {setState(() {
                      dropdownregion = value!;
                    });  },


                    )
                ),
                Spacer(),
                //PROFILE
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdownprofile,
                      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

                      items: const [
                        DropdownMenuItem(child: Text("profile1"),value: "profile1",),
                      ], onChanged: (String? value) {setState(() {
                      dropdownprofile = value!;
                    });  },


                    )
                ),
                Spacer(),
                //TASK TYPE
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdownTT,
                      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,

                      items: const [
                        DropdownMenuItem(child: Text("Browser"),value: "Browser",),
                        DropdownMenuItem(child: Text("Requests"),value: "Requests",),
                      ], onChanged: (String? value) {setState(() {
                      dropdownTT = value!;
                    });  },


                    )
                ),
                Spacer(),
                //TASK GROUP
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:  Color.fromRGBO(26, 25, 25, 0.6),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      dropdownColor: Color.fromRGBO(26, 25, 25, 1),
                      value: dropdownTG,
                      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                      style:TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 15) ,
                      items: const [
                        DropdownMenuItem(child: Text("group1"),value: "group1",),
                      ], onChanged: (String? value) {setState(() {
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