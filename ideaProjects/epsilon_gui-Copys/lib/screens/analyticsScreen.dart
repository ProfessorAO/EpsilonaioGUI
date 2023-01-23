import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              
              Expanded(
                child: dahboard(context),
              ),

            ],
          ),
        )
    );
  }

  Container dahboard(BuildContext context) {
    return Container(
                child: Stack(
                  children:  [
                   
                    background(),
                    EpsilonText(),
                    context.watch<TabbarIndex>().this_TopBar,
                  
                    

                  ],
                ),
              );
  }
}

