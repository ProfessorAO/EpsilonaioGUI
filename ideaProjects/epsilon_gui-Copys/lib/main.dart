import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:epsilon_gui/providers/console_logger_provider.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:epsilon_gui/providers/task_instance_provider.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/task_group_provider.dart';
import 'package:epsilon_gui/providers/stats_provider.dart';
import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/providers/release_data_provider.dart';
import 'package:epsilon_gui/providers/recent_checkouts_provider.dart';
import 'package:epsilon_gui/providers/task_options_provider.dart';
import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter/services.dart';
import 'package:epsilon_gui/screens/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksLists()),
        ChangeNotifierProvider(create: (_) => ConsoleLogger()),
        ChangeNotifierProvider(create: (_) => TasksInputs()),
        ChangeNotifierProvider(
            create: (_) => Taskinstance(0, "", "", "", "", "")),
        ChangeNotifierProvider(create: (_) => TabbarIndex()),
        ChangeNotifierProvider(create: (context) => TaskGroupList()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ReleasesData()),
        ChangeNotifierProvider(create: (_) => RecentCheckoutProvider()),
        ChangeNotifierProvider(create: (context) => ProfileGroupProvider()),
        ChangeNotifierProvider(create: (context) => TaskOptions()),
        ChangeNotifierProvider(
            create: (_) => ProfileInstance(
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                Profile_card(
                  profile_name: '',
                  address: '',
                  card_name: '',
                  card_no: '',
                  parent: ProfileProvider(),
                ),
                ProfileGroupProvider()))
      ],
      child: MyApp(),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle('Epsilon AIO');
  setWindowMaxSize(Size.infinite);
  setWindowMinSize(const Size(1366, 768));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Epsilon AIO',
      theme: ThemeData(primaryColor: Colors.grey, primarySwatch: Colors.grey),
      home: SplashScreen(),
    );
  }
}
