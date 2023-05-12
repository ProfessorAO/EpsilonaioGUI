import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:epsilon_gui/providers/analytics_provider.dart';

import 'package:epsilon_gui/providers/console_logger_provider.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/providers/task_instance_provider.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/task_group_provider.dart';
import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/providers/release_data_provider.dart';
import 'package:epsilon_gui/providers/recent_checkouts_provider.dart';
import 'package:epsilon_gui/providers/task_options_provider.dart';
import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:epsilon_gui/providers/user_data_provider.dart';
import 'package:epsilon_gui/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter/services.dart';
import 'package:epsilon_gui/screens/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await UserData.instance.loadData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksLists()),
        ChangeNotifierProvider(create: (_) => ConsoleLogger()),
        ChangeNotifierProvider(
            create: (_) => Taskinstance(
                0,
                "",
                "",
                Profile(
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
                      card_no: ''),
                ),
                "",
                [],
                false)),
        ChangeNotifierProvider(create: (_) => TabbarIndex()),
        ChangeNotifierProvider(create: (context) => TaskGroupList.instance),
        ChangeNotifierProvider(create: (_) => ProfileProvider.instance),
        ChangeNotifierProvider(create: (_) => ReleasesData()),
        ChangeNotifierProvider(create: (_) => RecentCheckoutProvider.instance),
        ChangeNotifierProvider(
            create: (context) => ProfileGroupProvider.instance),
        ChangeNotifierProvider(
            create: (context) => TaskOptions(ProfileGroupProvider.instance)),
        ChangeNotifierProvider(
          create: (_) => Profile(
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
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UserData.instance,
        ),
        ChangeNotifierProvider(create: (context) => Analytics.instance)
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
      home: LoginScreen(),
    );
  }
}
