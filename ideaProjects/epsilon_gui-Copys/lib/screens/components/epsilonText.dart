import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          style: TextStyle(fontSize: 125,
            fontFamily: 'Audiowide',
            color: Color.fromARGB(49, 184, 184, 184),
          )
      ),
    );
  }
}