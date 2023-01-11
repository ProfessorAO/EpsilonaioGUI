
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({Key? key}) : super(key: key);

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
                    children: const [
                      background(),
                      EpsilonText(),
                      TopBar(),

                    ],
                    //
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
}