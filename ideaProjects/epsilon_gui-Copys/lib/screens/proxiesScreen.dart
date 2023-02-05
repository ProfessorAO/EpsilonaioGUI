import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:epsilon_gui/screens/components/column_general.dart';
import 'package:flutter/gestures.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class ProxiesScreen extends StatelessWidget {
  const ProxiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 26, 59),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: dashboard(context),
              ),
            ],
          ),
        )
    );
  }

  Container dashboard(BuildContext context) {
    return Container(
                child: Stack(
                  children:  [
                    context.watch<TabbarIndex>().this_TopBar,
                    EpsilonText(),
                    bottomBar(),
                    ProxiesColumn(),
                    addProxy(context),
                  ],
                ),
              );
  }

  Positioned addProxy(BuildContext context) {
    return Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.width * 0.01,
                    child: TextButton(onPressed: (){
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
                        duration: Duration(milliseconds: 200),
                        childFun: (pop) {
                          return Container(
                            key: GlobalKey(),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: Color.fromARGB(255, 25, 36, 78),),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.37 ,
                                height: MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  
                                  border:  Border.all(color: Colors.white,width: 3)
                                  ),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,),
                              ),
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
                       child: const Text('Add Proxy') ),
                  );
  }
}

class ProxiesColumn extends StatelessWidget {
  const ProxiesColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height *0.08,
      left:    MediaQuery.of(context).size.width * 0.05,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9 ,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
                 border:  Border.all(color: Color.fromARGB(255, 25, 36, 78),width: 3)),
                
                headingRowColor:  MaterialStateColor.resolveWith((states) {return const Color.fromARGB(255, 25, 36, 78) ;},),
                columns: const [
                  DataColumn(label: table_Column(name:"ID"),
                  ),
                  DataColumn(label: table_Column(name:"IP")
                  ),
                  DataColumn(label: table_Column(name:"Port")
                  ),
                  DataColumn(label: table_Column(name:"Name")
                  ),
                  DataColumn(label:table_Column(name:"Ping")
                  ),
                  DataColumn(label:table_Column(name:"Status")
                  ),
                ],
                rows:[DataRow(cells: [
                  DataCell(Text("-")),
                  DataCell(Text("-")),
                  DataCell(Text("-")),
                  DataCell(Text("-")),
                  DataCell(Text("-")),
                  DataCell(Text("-"))
                  
                  
                  ])]
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}

