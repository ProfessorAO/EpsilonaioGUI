import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    MainScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

            colors: [Color.fromARGB(255, 17, 26, 59),Color.fromARGB(255, 25, 36, 78)]
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: IconButton(
                    icon: new SvgPicture.asset('assets/images/result-min 1.svg',color: Color.fromARGB(255, 15, 237, 120),height: 200,),
                    onPressed: (){},
                  ),
                ),
                Text("Solving everyday solutions with everyday bots",textAlign:TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),

            CircularProgressIndicator( 
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}