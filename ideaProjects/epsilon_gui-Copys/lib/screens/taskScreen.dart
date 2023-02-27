import 'package:epsilon_gui/providers/console_logger_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:epsilon_gui/providers/task_group_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/screens/components/column_general.dart';
import 'package:epsilon_gui/providers/stats_provider.dart';
import 'package:provider/provider.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:epsilon_gui/providers/task_options_provider.dart';

typedef StringVoidCallback = void Function(String?);
typedef StringCallback = void Function(String);

class tasks_screen extends StatefulWidget {
  const tasks_screen({super.key});

  @override
  tasksScreen createState() => tasksScreen();
}

class tasksScreen extends State<tasks_screen> {
  List<Widget> tasks = [];

  @override
  Widget build(BuildContext context) {
    context.read<TaskGroupList>().setContext(context);
    int task_list_number = context.watch<TasksLists>().count;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 26, 59),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      const EpsilonText(),
                      context.watch<TabbarIndex>().this_TopBar,
                      taskLists(taskinputs: tasks),
                      create_taskgroup_btn(context),
                      bottomBar(),
                      const startAll_button(),
                      const remove_all_button(),
                      Tasks_Stats(),
                      popUpMenu(context),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.5,
                        bottom: MediaQuery.of(context).size.height * 0.001,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Text(
                            "$task_list_number Tasks",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Positioned popUpMenu(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.17,
      child: TextButton(
          onPressed: () {
            String product = "";
            String dropdownsize = context.read<TaskOptions>().size_list.first;
            String dropdowncategory =
                context.read<TaskOptions>().category_list.first;
            String dropdownregion =
                context.read<TaskOptions>().region_list.first;
            String dropdownprofile =
                context.read<TaskOptions>().profile_list.first;
            String dropdownTT = context.read<TaskOptions>().taskType_list.first;
            String dropdownTG =
                context.read<TaskOptions>().proxyGroup_list.first;
            String dropdownstore = context.read<TaskOptions>().store_list.first;
            final myController = TextEditingController();
            final numController = TextEditingController();
            final keywordsController = TextEditingController();
            showPopupWindow(
              context,
              gravity: KumiPopupGravity.center,
              //curve: Curves.elasticOut,
              bgColor: const Color.fromARGB(255, 17, 26, 59).withOpacity(0.8),
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromARGB(255, 25, 36, 78),
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.01,
                          MediaQuery.of(context).size.height * 0.001,
                          0,
                          0),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: columInputer_text(
                                    length: 50,
                                    controller: myController,
                                    onChanged: (String value) {
                                      product = value;
                                    },
                                    label: "Product",
                                  )),
                              const Spacer(),
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    Menuitems:
                                        context.read<TaskOptions>().stores,
                                    value: dropdownstore,
                                    label: "Store",
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownstore = value!;
                                      });
                                    },
                                  )),
                              const Spacer(),
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    value: dropdownsize,
                                    label: "Size",
                                    Menuitems:
                                        context.read<TaskOptions>().sizes,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownsize = value!;
                                      });
                                    },
                                  )),
                              const Spacer(),
                              //CATEGORY
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    value: dropdowncategory,
                                    label: "Clothing Category",
                                    Menuitems: context
                                        .read<TaskOptions>()
                                        .clothingTypes,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdowncategory = value!;
                                      });
                                    },
                                  )),
                              //COLOR
                              const Spacer(),
                              Expanded(
                                  flex: 2,
                                  child: columInputer_text(
                                    controller: keywordsController,
                                    length: 20,
                                    label: "Color",
                                    onChanged: (String value) {
                                      context
                                          .read<TasksInputs>()
                                          .setNum_of_tasks(int.parse(value));
                                    },
                                  )),
                              const Spacer(),
                              // TASK NUMBER
                              Expanded(
                                  flex: 2,
                                  child: columInputer_text(
                                    controller: numController,
                                    length: 2,
                                    label: "Number of Tasks",
                                    onChanged: (String value) {
                                      context
                                          .read<TasksInputs>()
                                          .setNum_of_tasks(int.parse(value));
                                    },
                                  )),
                              const Spacer(),
                              // REGION
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    value: dropdownregion,
                                    label: "Region",
                                    Menuitems:
                                        context.read<TaskOptions>().regions,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownregion = value!;
                                      });
                                    },
                                  )),
                              const Spacer(),
                              //PROFILE
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    value: dropdownprofile,
                                    label: "Profile",
                                    Menuitems:
                                        context.read<TaskOptions>().profiles,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownprofile = value!;
                                      });
                                    },
                                  )),
                              const Spacer(),
                              //TASK TYPE
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    value: dropdownTT,
                                    label: "Task Type",
                                    Menuitems:
                                        context.read<TaskOptions>().taskTypes,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownTT = value!;
                                      });
                                    },
                                  )),
                              const Spacer(),
                              //TASK GROUP
                              Expanded(
                                  flex: 2,
                                  child: columnInput_Menu(
                                    value: dropdownTG,
                                    label: "Proxy Group",
                                    Menuitems:
                                        context.read<TaskOptions>().proxies,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownTG = value!;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: const Text('Task Created'),
                                    action: SnackBarAction(
                                      label: '',
                                      onPressed: () {},
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  context
                                      .read<TasksInputs>()
                                      .setproduct(product);
                                  context
                                      .read<TasksInputs>()
                                      .setsize(dropdownsize);
                                  context
                                      .read<TasksInputs>()
                                      .setprofile(dropdownprofile);
                                  context
                                      .read<TasksInputs>()
                                      .setstore(dropdownstore);
                                  context.read<TasksLists>().addTask(
                                      context.read<TasksInputs>().tasks_num,
                                      context.read<TasksInputs>().task_store,
                                      context.read<TasksInputs>().product,
                                      context.read<TasksInputs>().task_profile,
                                      context.read<TasksInputs>().task_size,
                                      context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Text("Save")))
                      ]),
                    ));
              },
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          child: const Text('Create task')),
    );
  }

  Positioned create_taskgroup_btn(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.72,
      top: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.height * 0.82,
        child: Column(children: [
          Expanded(
            flex: 1,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.28,
                      MediaQuery.of(context).size.height * 0.1)
                  //padding: const EdgeInsets.all(16.0),
                  ),
              onPressed: () {
                String product = "";
                String group_name = "";
                String dropdownsize =
                    context.read<TaskOptions>().size_list.first;
                String dropdowncategory =
                    context.read<TaskOptions>().category_list.first;
                String dropdownregion =
                    context.read<TaskOptions>().region_list.first;
                String dropdownprofile =
                    context.read<TaskOptions>().profile_list.first;
                String dropdownTT =
                    context.read<TaskOptions>().taskType_list.first;
                String dropdownPG =
                    context.read<TaskOptions>().proxyGroup_list.first;
                String dropdownstore =
                    context.read<TaskOptions>().store_list.first;
                int taskNumber = 0;
                final productController = TextEditingController();
                final taskGroupController = TextEditingController();
                final numController = TextEditingController();
                final keywordsController = TextEditingController();
                showPopupWindow(context,
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
                    duration: Duration(milliseconds: 200), childFun: (pop) {
                  return Container(
                      key: GlobalKey(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 25, 36, 78),
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.45,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.001,
                            0,
                            0),
                        child: Row(children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: columInputer_text(
                                      length: 20,
                                      controller: taskGroupController,
                                      onChanged: (String value) {
                                        group_name = value;
                                      },
                                      label: "Task Group Name",
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 2,
                                    child: columInputer_text(
                                      length: 50,
                                      controller: productController,
                                      onChanged: (String value) {
                                        product = value;
                                      },
                                      label: "Product",
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "Trapstar",
                                          child: Text("Trapstar"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Palace-Clothing",
                                          child: Text("Palace-Clothing"),
                                        ),
                                      ],
                                      value: dropdownstore,
                                      label: "Store",
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownstore = value!;
                                        });
                                      },
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      value: dropdownsize,
                                      label: "Size",
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "XS",
                                          child: Text("XS"),
                                        ),
                                        DropdownMenuItem(
                                          value: "S",
                                          child: Text("S"),
                                        ),
                                        DropdownMenuItem(
                                          value: "M",
                                          child: Text("M"),
                                        ),
                                        DropdownMenuItem(
                                          value: "L",
                                          child: Text("L"),
                                        ),
                                        DropdownMenuItem(
                                          value: "XL",
                                          child: Text("XL"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownsize = value!;
                                        });
                                      },
                                    )),
                                const Spacer(),
                                //CATEGORY
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      value: dropdowncategory,
                                      label: "Clothing Category",
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "Sneakers",
                                          child: Text("Sneakers"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Jackets",
                                          child: Text("Jackets"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Bottoms",
                                          child: Text("Bottoms"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Jumpers",
                                          child: Text("Jumpers"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Shirts",
                                          child: Text("T-Shirts"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdowncategory = value!;
                                        });
                                      },
                                    )),
                                //COLOR
                                const Spacer(),
                                Expanded(
                                    flex: 2,
                                    child: columInputer_text(
                                      controller: keywordsController,
                                      label: "Color",
                                      length: 20,
                                      onChanged: (String value) {},
                                    )),
                                const Spacer(),
                                // TASK NUMBER
                                Expanded(
                                    flex: 2,
                                    child: columInputer_text(
                                      controller: numController,
                                      label: "Number of Tasks",
                                      length: 2,
                                      onChanged: (String value) {
                                        taskNumber = int.parse(value);
                                      },
                                    )),
                                const Spacer(),
                                // REGION
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      value: dropdownregion,
                                      label: "Region",
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "UK",
                                          child: Text("UK"),
                                        ),
                                        DropdownMenuItem(
                                          value: "US",
                                          child: Text("US"),
                                        ),
                                        DropdownMenuItem(
                                          value: "EU",
                                          child: Text("EU"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownregion = value!;
                                        });
                                      },
                                    )),
                                const Spacer(),
                                //PROFILE
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      value: dropdownprofile,
                                      label: "Profile Group",
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "profile1",
                                          child: Text("profile1"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownprofile = value!;
                                        });
                                      },
                                    )),
                                const Spacer(),
                                //TASK TYPE
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      value: dropdownTT,
                                      label: "Task Type",
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "Browser",
                                          child: Text("Browser"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Requests",
                                          child: Text("Requests"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownTT = value!;
                                        });
                                      },
                                    )),
                                const Spacer(),
                                //TASK GROUP
                                Expanded(
                                    flex: 2,
                                    child: columnInput_Menu(
                                      value: dropdownPG,
                                      label: "Proxy Group",
                                      Menuitems: const [
                                        DropdownMenuItem(
                                          value: "group1",
                                          child: Text("group1"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownPG = value!;
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.green,
                                      content: const Text('Task Group Created'),
                                      action: SnackBarAction(
                                        label: '',
                                        onPressed: () {},
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    context
                                        .read<TaskGroupList>()
                                        .setGroupName(group_name);
                                    context
                                        .read<TaskGroupList>()
                                        .setTaskProduct(product);
                                    context
                                        .read<TaskGroupList>()
                                        .setTaskSize(dropdownsize);
                                    context
                                        .read<TaskGroupList>()
                                        .setTaskProfile(dropdownprofile);
                                    context
                                        .read<TaskGroupList>()
                                        .setTaskStore(dropdownstore);
                                    context
                                        .read<TaskGroupList>()
                                        .setTaskNum(taskNumber);
                                    context
                                        .read<TaskGroupList>()
                                        .addToGroupList(context);

                                    setState(() {});
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Text("Save group")))
                        ]),
                      ));
                });
              },
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'New Task Group',
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 0.006, 0, 0),
                    child: Icon(
                      Icons.add,
                      size: MediaQuery.of(context).size.height * 0.027,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 9,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Color.fromARGB(255, 25, 36, 78), width: 3)),
                  child: RawScrollbar(
                      child: SingleChildScrollView(child: taskGroupColumn()))

                  //width: MediaQuery.of(context).size.width * 0.265,

                  )),
        ]),
      ),
    );
  }
}

class Tasks_Stats extends StatelessWidget {
  const Tasks_Stats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.27,
      bottom: MediaQuery.of(context).size.height * 0.001,
      child: Row(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            0,
            0,
            MediaQuery.of(context).size.height * 0.01,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.watch<StatsProvider>().successes.toString(),
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 21, 48, 22),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.01,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            0,
            0,
            MediaQuery.of(context).size.height * 0.01,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.watch<StatsProvider>().fails.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 63, 18, 14),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.01,
        ),
      ]),
    );
  }
}

class taskGroupColumn extends StatefulWidget {
  const taskGroupColumn({
    super.key,
  });
  @override
  State<taskGroupColumn> createState() => taskGroupColumn_state();
}

class taskGroupColumn_state extends State<taskGroupColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(children: context.watch<TaskGroupList>().group_list);
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
      left: MediaQuery.of(context).size.width * 0.1,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {
          context.read<TasksLists>().startAllTasks();
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: const Text('Tasks Started'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        onPressed: () {
          context.read<TasksLists>().removeAllTasks();
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: const Text('Tasks Removed'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      top: MediaQuery.of(context).size.height * 0.08,
      left: -MediaQuery.of(context).size.width * 0.005,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.84,
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: Color.fromARGB(255, 25, 36, 78), width: 3)),
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return const Color.fromARGB(255, 25, 36, 78);
                  },
                ),
                columns: const [
                  DataColumn(
                    label: table_Column(name: "ID"),
                  ),
                  DataColumn(label: table_Column(name: "Store")),
                  DataColumn(label: table_Column(name: "Product")),
                  DataColumn(label: table_Column(name: "Size")),
                  DataColumn(label: table_Column(name: "Profile")),
                  DataColumn(label: table_Column(name: "Status")),
                  DataColumn(label: table_Column(name: "Actions")),
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

class Console extends StatelessWidget {
  const Console({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.01,
      bottom: MediaQuery.of(context).size.height * 0.02,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        color: const Color.fromARGB(255, 25, 36, 78),
        child: Align(
          alignment: Alignment.topLeft,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  for (var text in context.watch<ConsoleLogger>().log)
                    Text(text, style: const TextStyle(color: Colors.white))
                ],
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
    super.key,
    required this.tasks,
  });
  final List<Widget> tasks;
  @override
  State<create_button> createState() => _create_buttonState();
}

class _create_buttonState extends State<create_button> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      left: ((MediaQuery.of(context).size.width) * 0.3) +
          (MediaQuery.of(context).size.width * 0.59) -
          220,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'Audiowide',
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          context.read<ConsoleLogger>().logOuput_createTask("User 1");
        },
        child: const Text('Create'),
      ),
    );
  }
}

class columInputer_text extends StatelessWidget {
  const columInputer_text({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.label,
    required this.length,
  });

  final TextEditingController controller;
  final StringCallback onChanged;
  final String label;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 25, 36, 78),
      child: TextField(
          style: const TextStyle(
              fontFamily: 'Audiowide', color: Colors.white, fontSize: 16),
          controller: controller,
          maxLength: length,
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            label: Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.all(8),
          )),
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
          label: Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 25, 36, 78),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.all(8),
        ),
        dropdownColor: const Color.fromRGBO(26, 25, 25, 1),
        value: value,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        style: const TextStyle(
            fontFamily: 'Audiowide', color: Colors.white, fontSize: 15),
        items: Menuitems,
        onChanged: onChanged);
  }
}

class taskInputData extends StatelessWidget {
  const taskInputData({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(name,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Audiowide',
              color: Color.fromARGB(255, 15, 237, 120),
            )),
      ),
    );
  }
}
