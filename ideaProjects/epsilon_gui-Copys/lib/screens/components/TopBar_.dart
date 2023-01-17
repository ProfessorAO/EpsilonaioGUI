import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:epsilon_gui/screens/accountsScreen.dart';
import 'package:epsilon_gui/screens/analyticsScreen.dart';
import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:epsilon_gui/screens/profilesScreen.dart';
import 'package:epsilon_gui/screens/proxiesScreen.dart';
import 'package:epsilon_gui/screens/taskScreen.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/CustomPackages/OnHoverText.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     int current_index = 0;
    return Column(
      children: [
        Container(
          color:Color.fromARGB(255, 25, 36, 78) ,
          height: 48,
          child: WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: new SvgPicture.asset('assets/images/result-min 1.svg',height: 30,color: Color.fromARGB(255, 15, 237, 120),)
                          
                          ),
                        Container(width: 30,),
                      ],
                    ),
                  ),
                  ),
                
                Expanded(
                  flex: 5,
                  child:  DefaultTabController(
                    initialIndex: current_index,
                    length: 5,
                    child: Scaffold(
                      backgroundColor: Color.fromARGB(255, 25, 36, 78),
                      appBar: AppBar(
                        elevation: 0,
                        shadowColor: Color.fromARGB(255, 25, 36, 78),
                        backgroundColor:Color.fromARGB(255, 25, 36, 78) ,
                        toolbarHeight: 0,
                        bottom: TabBar(
                          indicator: BoxDecoration(color: Color.fromARGB(255, 17, 26, 59),),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white60,
                          indicatorColor: Color.fromARGB(255, 17, 26, 59),
                          tabs: <Widget>[
                            Tab(child:GestureDetector(
                              onTap: (){Navigator.pop(context);
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: MainScreen(),duration: const Duration(milliseconds: 10)));current_index = 0;},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Home'),
                                  Text(" "),
                                  Icon(Icons.home),
                                
                                  
                              ],
                                                       ),
                            ),),
                           Tab(child:GestureDetector(
                            onTap: (){Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ProxiesScreen(),duration: const Duration(milliseconds: 10))); current_index =1;},
                             child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Proxies'),
                                  Text(" "),
                                  Icon(Icons.computer),
                                  
                                  
                              ],
                             ),
                           ),),
                            Tab(child:GestureDetector(
                               onTap: (){Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: tasks_screen(),duration: const Duration(milliseconds: 10)));current_index =2;},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Tasks'),
                                  Text(" "),
                                  Icon(Icons.checklist),
                              
                                  
                              ],
                                                       ),
                            ),),
                            Tab(child:GestureDetector(
                               onTap: (){Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ProfilesScreen(),duration: const Duration(milliseconds: 10)));current_index =3;},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Billing'),
                                  Text(" "),
                                  Icon(Icons.credit_card),
                                  
                              ],
                                                       ),
                            ),),
                            Tab(child:GestureDetector(
                               onTap: (){Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AnalyticsScreen(),duration: const Duration(milliseconds: 10)));current_index =4;},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Analytics'),
                                  Text(" "),
                                  Icon(Icons.show_chart),
                                  
                                  
                              ],
                                                       ),
                            ),),
                           //SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                            

                            ]
                            ),
                            ),
                  ),
                ),),
                Expanded(
                  flex: 1,
                  child: MoveWindow(
                  ),
                ),
              
                Expanded(
                  flex: 3,
                  child: infoBar(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0,0 , 0),
                  child: WindowsButtons(),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
class WindowsButtons extends StatelessWidget{
  String currdate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        MinimizeWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.blueAccent,mouseOver: Color.fromARGB(255, 25, 36, 78))),
        //MaximizeWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.blueAccent)),
        CloseWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.red,mouseOver:Color.fromARGB(255, 25, 36, 78) )),
      ],
    );
  }
}
class infoBar extends StatelessWidget{
  String currdate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Container(
        //   height : 29,
        //   width:  MediaQuery.of(context).size.width * 0.6/2,
        //   color: const Color.fromRGBO(26, 25, 25, 0.6),
        //   child: const TextField(
        //     style:TextStyle(fontFamily: 'Audiowide',color: Colors.white70,fontSize: 20) ,
        //     decoration: InputDecoration( labelStyle: TextStyle(fontFamily: 'Audiowide',color: Colors.white30,fontSize: 20),
        //       border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        //       labelText: 'Search',),

        //   ),
        // ),
        Padding (
          padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SizedBox(
            width: 95,
            height: 27,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                currdate,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 13),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: OnHoverText(
            child: Icon(Icons.discord,color: Color.fromRGBO(88,101,242,1.0),size: 30,),
          ),
        ),

        OnHoverText(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Icon(Icons.notifications_active,color: Colors.white,size: 28,)
             
          ),
        ),
        OnHoverText(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Icon(Icons.settings,color: Colors.white,size: 28,),
          ),
        ),
        Align(
          alignment:Alignment.center ,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Container(
              color: Colors.black26,
              width: 85,
              height: 30,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  "User1",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        OnHoverText(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,2, 0, 0),
            child: CircleAvatar(
              backgroundColor: Color(1692195289),
              child: Text(
                'U1',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15,color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}
