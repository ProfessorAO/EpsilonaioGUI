import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 26, 59),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: dahboard(context),
              ),
            ],
          ),
        ));
  }

  Container dahboard(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          EpsilonText(),
          bottomBar(),
          context.watch<TabbarIndex>().this_TopBar,
          NewWidget(),
          Widget_one()
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      left: MediaQuery.of(context).size.width * 0.02,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.63,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: Color.fromARGB(255, 17, 26, 59),
            border:
                Border.all(color: Color.fromARGB(255, 25, 36, 78), width: 3)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sentiment Analysis",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Audiowide',
                    color: Color.fromARGB(188, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  style: const TextStyle(
                      fontFamily: 'Audiowide',
                      color: Colors.white,
                      fontSize: 16),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 25, 36, 78))),
                      counterText: '',
                      label: Text(
                        'Product to be analysed',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}

class Widget_one extends StatelessWidget {
  const Widget_one({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      right: MediaQuery.of(context).size.width * 0.02,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: Color.fromARGB(255, 17, 26, 59),
            border:
                Border.all(color: Color.fromARGB(255, 25, 36, 78), width: 3)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Results",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Audiowide',
                    color: Color.fromARGB(188, 255, 255, 255),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
