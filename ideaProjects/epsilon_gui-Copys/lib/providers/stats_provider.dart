import 'package:flutter/material.dart';

class StatsProvider with ChangeNotifier{
  int success_number = 0;
  int fail_number = 0;

  int get successes => success_number;
  int get fails => fail_number;

  void incrementSuccesses(){
    success_number+=1;
  }
  void incrementFails(){
    fail_number+=1;
  }

  
}