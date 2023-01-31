import 'package:flutter/material.dart';

class table_Column extends StatelessWidget {
  const table_Column({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name,style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Audiowide',
      fontSize: 15,
    ),);
  }
}