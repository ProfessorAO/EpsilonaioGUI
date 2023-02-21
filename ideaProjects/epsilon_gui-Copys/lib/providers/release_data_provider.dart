import 'package:epsilon_gui/screens/home/main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:javascript/javascript.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class ReleasesData with ChangeNotifier{
  List<dynamic> recieved_data = [];
  List<Map<String,String>> releases_data = [];
  String data = "";

  List<Map<String,String>> get releasesData => releases_data;

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
          print('Data Recieved');
          recieved_data = JSON.parse(event);
          //print(recieved_data[0]);
          //print(data_map);
          CreateMap(recieved_data);
          
        });

      } on SocketException catch (e){
          print("Error on Connecting to server$e");
      }on PlatformException catch(e){
        print('error: ${e.details}');
      }
  

   }
   void CreateMap(data){
    for(int i = 0 ; i <=5 ; i++){
      var map = <String, String>{
        'name':data[i]['name'].toString(),
        'date':data[i]['releaseDate'].toString(),
        'price':data[i]['retailPrice'].toString(),
        'img':data[i]['small'].toString(),
      };
      releases_data.add(map);

    }
   }



}
