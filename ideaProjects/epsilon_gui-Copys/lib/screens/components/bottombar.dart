import 'package:flutter/material.dart';
class bottomBar extends StatelessWidget {
  const bottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
     bottom: MediaQuery.of(context).size.height * 0.0001,
     child: Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.04, 0, 0),
                child: Text(
                  "Version 1.0",
                  textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                   fontFamily: "Audiowide",
                   fontSize: 13
                   
                   ),),
              ),
                   color: Color.fromARGB(255, 25, 36, 78),
                   width: MediaQuery.of(context).size.width * 1,
                   height: MediaQuery.of(context).size.height * 0.065,
  
                 ),
                      );
  }
}