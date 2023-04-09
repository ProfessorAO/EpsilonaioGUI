import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Analytics with ChangeNotifier {
  static final Analytics _instance = Analytics._internal();
  Analytics._internal();

  static Analytics get instance => _instance;
}
