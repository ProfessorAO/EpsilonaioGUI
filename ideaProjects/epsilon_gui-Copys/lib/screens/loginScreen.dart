import 'package:epsilon_gui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final ValueNotifier<bool> startAnalysisNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 13, 19, 39),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: LoginInputs(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Color.fromARGB(255, 25, 36, 78),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          13, // adjust this for your desired grid layout
                    ),
                    itemBuilder: (context, index) {
                      int gridState = (index ~/ 6 + index % 6) %
                          5; // Change '6' to your crossAxisCount
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: gridState == 0
                            ? Container(
                                width: 20.0, // adjust for your logo size
                                height: 20.0, // adjust for your logo size
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: SvgPicture.asset(
                                      'assets/images/result-min 1.svg', // your SVG image
                                    ),
                                  ),
                                ),
                              )
                            : Container(), // empty container to create a diamond pattern
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Container dahboard(BuildContext context) {
    return Container(
      child: Stack(
        children: [IconScreen(), LoginInputs()],
      ),
    );
  }
}

//color: Color.fromARGB(255, 17, 26, 59),
class IconScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.sizeOf(context).width * 0.2,
      top: MediaQuery.sizeOf(context).height * 0.1,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Opacity(
          opacity: 0.4,
          child: new SvgPicture.asset(
            'assets/images/result-min 1.svg',
          ),
        ),
      ),
    );
  }
}

class LoginInputs extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: MediaQuery.sizeOf(context).height * 0.05,
        left: MediaQuery.sizeOf(context).width * 0.01,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 35,
                child: SvgPicture.asset(
                  'assets/images/result-min 1.svg',
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "ENIGMA",
                  style: TextStyle(
                      letterSpacing: 3,
                      color: Color.fromARGB(255, 15, 237, 120),
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.28,
            child: Column(children: [
              const Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Enigma",
                        style: TextStyle(
                            color: Color.fromARGB(255, 15, 237, 120),
                            fontSize: 35,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                width: MediaQuery.sizeOf(context).width * 0.28,
                color: Color.fromARGB(255, 25, 36, 78),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      controller: controller,
                      maxLength: 30,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        counterText: '',
                        label: Text(
                          "Username",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      )),
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                width: MediaQuery.sizeOf(context).width * 0.28,
                color: Color.fromARGB(255, 25, 36, 78),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      controller: controller,
                      maxLength: 30,
                      decoration: InputDecoration(
                        icon: Transform.rotate(
                          angle: 3.14159 / 2,
                          child: Icon(
                            Icons.key,
                            size: 30,
                          ),
                        ),
                        counterText: '',
                        label: Text(
                          "License-key",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      )),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Container(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: SplashScreen(),
                            duration: const Duration(milliseconds: 300)));
                  },
                  child: Text("LOGIN"),
                  style: TextButton.styleFrom(
                    minimumSize: Size(150, 60),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ])),
      ),
    ]);
  }
}
