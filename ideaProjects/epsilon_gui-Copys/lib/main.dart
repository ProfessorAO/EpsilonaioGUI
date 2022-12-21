import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:epsilon_gui/providers/console_logger_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:universal_io/io.dart';

void main() {
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> TasksLists()),
      ChangeNotifierProvider(create: (_)=> ConsoleLogger()),
      ChangeNotifierProvider(create: (_)=> TasksInputs()),
  ],
    child:MyApp() ,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle('Epsilon AIO');
  setWindowMaxSize(Size.infinite);
  setWindowMinSize(const Size(1600, 830));
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