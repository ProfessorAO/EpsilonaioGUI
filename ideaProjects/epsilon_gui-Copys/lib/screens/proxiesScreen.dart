import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:provider/provider.dart';

class ProxiesScreen extends StatelessWidget {
  const ProxiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    background(),
                    context.watch<TabbarIndex>().this_TopBar,
                    EpsilonText(),
                  ],
                ),
              );
  }
}

