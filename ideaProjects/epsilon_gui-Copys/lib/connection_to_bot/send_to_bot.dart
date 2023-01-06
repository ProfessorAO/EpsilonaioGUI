import 'package:web_socket_channel/io.dart';

void sendToBot(){
    IOWebSocketChannel? channel;

    try{
      channel = IOWebSocketChannel.connect('ws://localhost:3000');
    }catch (e){
      print("Error on Connecting to server$e");
    }

    channel?.sink.add("connected");

    channel?.stream.listen((event){
      print(event);
      
    });

  }
