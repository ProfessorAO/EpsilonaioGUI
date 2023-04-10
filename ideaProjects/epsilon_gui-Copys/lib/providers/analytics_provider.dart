import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Analytics with ChangeNotifier {
  static final Analytics _instance = Analytics._internal();
  Analytics._internal();

  static Analytics get instance => _instance;

  void getSematicAnalysisResult(
      String product, List<String> keywords, int sentimentNumber) async {
    Completer<List<Map<String, String>>> completer = Completer();
    try {
      IOWebSocketChannel? channel;

      try {
        channel = IOWebSocketChannel.connect('ws://localhost:679');
        if (channel == null) {
          throw const SocketException("");
        }
      } catch (e) {
        print("Error on Connecting to server$e");
      }
      var map = jsonEncode(dataSentMap(product, keywords, sentimentNumber));
      channel?.sink.add(map);
      channel?.stream.listen((event) {
        print(event);
        var recieved_data = jsonDecode(event);
      });
    } on SocketException catch (e) {
      print("Error on Connecting to server$e");
      completer.completeError(e);
    } on PlatformException catch (e) {
      print('error: ${e.details}');
      completer.completeError(e);
    }
  }

  Map<String, dynamic> dataSentMap(
      String product, List<String> keywords, int sentimentNumber) {
    var dataMap = <String, dynamic>{
      'eventType': 'Semantic Analysis Request',
      'product': product,
      'keywords': keywords,
      'sentimentNumber': sentimentNumber
    };
    return dataMap;
  }
}
