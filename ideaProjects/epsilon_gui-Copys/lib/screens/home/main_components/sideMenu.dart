import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../accountsScreen.dart';
import '../../analyticsScreen.dart';
import '../../profilesScreen.dart';
import '../../proxiesScreen.dart';
import '../../taskScreen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: color,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                child: Image.asset("assets/images/EpsilonAIO Logo_Color Favicon.png",
                    width: 100,
                    alignment: Alignment.center)
            ),
            DrawerListTile(title: "Home",
              src: "assets/images/home green.png",
              press: (){
                Navigator.pop(context);
                Navigator.push(context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: MainScreen(),
                        duration: const Duration(milliseconds: 10)));

              },
            ),
            DrawerListTile(title: "Proxies",
              src: "assets/images/proxies.png",
              press: (){
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ProxiesScreen(),duration: const Duration(milliseconds: 10)));

              },
            ),
            DrawerListTile(title: "Tasks",
              src: "assets/images/to-do-list.png",
              press: (){
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: tasks_screen(),duration: const Duration(milliseconds: 10)));
              },
            ),
            DrawerListTile(title: "Profiles",
              src: "assets/images/credit-cards.png",
              press: (){
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ProfilesScreen(),duration: const Duration(milliseconds: 10)));
              },
            ),
            DrawerListTile(title: "Analytics",
              src: "assets/images/business (1) 512.png",
              press: (){
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AnalyticsScreen(),duration: const Duration(milliseconds: 10)));
              },
            ),
            DrawerListTile(title: "Account",
              src: "assets/images/account.png",
              press: (){

                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AccountScreen(),duration: const Duration(milliseconds: 10)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,

    required this.title,
    required this.src,
    required this.press,
  }) : super(key: key);

  final String title, src;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      hoverColor: Colors.white12,
      selectedTileColor:Colors.white12 ,
      horizontalTitleGap: .0,
      trailing: Image.asset(
        src,
        color: Color.fromARGB(255, 15, 237, 120),
        height:30,
      ),
      leading: Text(title,style: TextStyle(fontSize: 11, fontFamily: 'Audiowide',color: Color.fromARGB(255, 15, 237, 120))),
    );
  }
}



