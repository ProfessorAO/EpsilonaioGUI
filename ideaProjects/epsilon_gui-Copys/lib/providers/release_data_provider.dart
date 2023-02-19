import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class ReleasesData with ChangeNotifier{
  List<Map<String,String>> releases_data = [];



    void getData() async{
        try{
        IOWebSocketChannel? channel;
        
        try{
          channel = IOWebSocketChannel.connect('ws://localhost:6969');
          if (channel==null){
            throw const SocketException("");
          }

        } catch (e){
          print("Error on Connecting to server$e");
        }
        channel?.sink.add("Connnected");
        channel?.stream.listen((event){
          print(event);
        });

      } on SocketException catch (e){
          print("Error on Connecting to server$e");
      }on PlatformException catch(e){
        print('error: ${e.details}');
      }
  

   }



}
