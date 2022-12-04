import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:universal_io/io.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS  ) {
    setWindowTitle('Epsilon AIO');
    setWindowMaxSize(Size.infinite);
    setWindowMinSize(const Size(1600, 830));
    doWhenWindowReady(() {
      const initialSize =  Size(1600, 830);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();

    });
  }
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Epsilon AIO',
      theme:ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey
      ),
    home: MainScreen(),
    );
  }
}