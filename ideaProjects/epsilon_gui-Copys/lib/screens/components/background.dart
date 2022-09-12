import 'package:flutter/cupertino.dart';
import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class background extends StatelessWidget {
  const background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gui back--.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}