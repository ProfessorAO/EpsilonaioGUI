import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:flutter/material.dart';

class TabbarIndex with ChangeNotifier{
  int index = 0;
  late TabController tabController;
  TopBar topbar = new TopBar();

  int get current_index => index;
  TabController get controller => tabController;
  TopBar get this_TopBar => topbar;




  void setIndex(int newIndex){index = newIndex;}
  void setTopBar(TopBar newtopbar){topbar = newtopbar;}
}