import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ReleasesData with ChangeNotifier {
  List<dynamic> recieved_data = [];
  List<Map<String, String>> releases_data = [];

  String data = "";

  List<Map<String, String>> get releasesData => releases_data;

  Future<List<Map<String, String>>> getData() async {
    bool is_data = false;
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
      var map = jsonEncode(dataSentMap());
      channel?.sink.add(map);
      channel?.stream.listen((event) {
        print('Data Recieved');
        recieved_data = jsonDecode(event);
        List<Map<String, String>> data = CreateMap(recieved_data);
        completer.complete(data);
      });
    } on SocketException catch (e) {
      print("Error on Connecting to server$e");
      completer.completeError(e);
    } on PlatformException catch (e) {
      print('error: ${e.details}');
      completer.completeError(e);
    }

    return completer.future;
  }

  List<Map<String, String>> CreateMap(data) {
    for (int i = 0; i <= 5; i++) {
      var map = <String, String>{
        'name': data[i]['name'].toString(),
        'date': data[i]['releaseDate'].toString(),
        'price': data[i]['retailPrice'].toString(),
        'img': data[i]['image']['small'].toString(),
      };
      releases_data.add(map);
    }
    return releases_data;
  }

  Map<String, dynamic> dataSentMap() {
    var dataMap = <String, dynamic>{
      'eventType': 'Release Data Request',
      'comment': 'Connected'
    };
    return dataMap;
  }
}
