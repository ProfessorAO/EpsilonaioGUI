import 'dart:math';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

void sendToBot(){
  try{
     IOWebSocketChannel? channel;
    try{
      channel = IOWebSocketChannel.connect('ws://localhost:3000');
    }catch (e){
      print("Error on Connecting to server$e");
    }

    channel?.sink.add("Connected");

    channel?.stream.listen((event){
      print(event);
      
      
      
      
  

    });

  }on PlatformException catch(e){
    print('error: ${e.details}');
  }
   
  }
