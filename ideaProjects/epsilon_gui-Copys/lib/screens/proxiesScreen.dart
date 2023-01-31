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
                  ],
                ),
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
      left:    -MediaQuery.of(context).size.width * 0.005,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
                 border:  Border.all(color: Color.fromARGB(255, 25, 36, 78),width: 3)),
                
                headingRowColor:  MaterialStateColor.resolveWith((states) {return const Color.fromARGB(255, 25, 36, 78) ;},),
                columns: const [
                  DataColumn(label: table_Column(name:"ID"),
                  ),
                  DataColumn(label: table_Column(name:"Store")
                  ),
                  DataColumn(label: table_Column(name:"Product")
                  ),
                  DataColumn(label: table_Column(name:"Profile")
                  ),
                  DataColumn(label:table_Column(name:"Status")
                  ),
                  DataColumn(label:table_Column(name:"Actions")
                  ),
                ],
                rows:[DataRow(cells: [
                  DataCell(Text("This")),
                  DataCell(Text("This")),
                  DataCell(Text("This")),
                  DataCell(Text("This")),
                  DataCell(Text("This")),
                  DataCell(Text("This"))
                  
                  
                  ])]
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}

