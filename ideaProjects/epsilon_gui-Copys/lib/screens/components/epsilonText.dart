import 'package:flutter/cupertino.dart';
import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class EpsilonText extends StatelessWidget {
  const EpsilonText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Baseline(
      baseline: MediaQuery.of(context).size.height -5,
      baselineType: TextBaseline.alphabetic,
      child: const Text("EPSILON AIO",
          style: TextStyle(fontSize: 150,
            fontFamily: 'Audiowide',
            color: Color.fromARGB(70, 26, 25, 25),
          )
      ),
    );
  }
}