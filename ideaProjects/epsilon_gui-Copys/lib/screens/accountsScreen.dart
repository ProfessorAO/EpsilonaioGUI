import 'package:flutter/cupertino.dart';
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

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
                    children: const [
                      background(),
                      EpsilonText(),

                    ],
                    //
                  ),
                ),
              ),


              // Container(
              //     child: DashboardScreen()
              //
              // ),
            ],
          ),
        )
    );
  }
}