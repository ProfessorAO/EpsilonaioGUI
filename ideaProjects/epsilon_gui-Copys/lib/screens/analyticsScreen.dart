import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/background.dart';
import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:provider/provider.dart';

import 'package:kumi_popup_window/kumi_popup_window.dart';

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
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
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
                            style:
                                TextStyle(color: Colors.white54, fontSize: 16),
                          )),
                    )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
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
                                'Keywords - seperate them by + or - and a space',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16),
                              )),
                        )),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  child: Text("Start Analysis"),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
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
                            'Number of sentiments analysed',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 16),
                          )),
                    )),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.width * 0.02),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    onPressed: () {
                      showPopupWindow(context,
                          gravity: KumiPopupGravity.center,
                          //curve: Curves.elasticOut,
                          bgColor: const Color.fromARGB(255, 17, 26, 59)
                              .withOpacity(0.8),
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
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.width * 0.45,
                          key: GlobalKey(),
                          child: Text(
                            "Sentiment analysis is a powerful natural language processing technique that evaluates the emotions and opinions expressed in text, providing valuable insights into public sentiment. In the context of our sneaker bot, it helps sneaker enthusiasts understand the general opinions and feelings towards specific sneaker models or releases by analyzing tweets and other online sources. This information enables users to make informed decisions about purchasing, selling, or trading sneakers, as well as offering brands and retailers insight into customer satisfaction and potential areas for improvement.",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        );
                      });
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 50,
                    )),
              ),
            )
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
