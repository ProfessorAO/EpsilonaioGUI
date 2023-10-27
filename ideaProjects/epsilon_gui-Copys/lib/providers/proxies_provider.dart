import 'package:flutter/material.dart';

class ProxiesProvider with ChangeNotifier {
  static final ProxiesProvider _instance = ProxiesProvider._internal();
  ProxiesProvider._internal();

  List<Proxy> all_proxies = [];
}

class Proxy with ChangeNotifier {}
