import 'dart:async';
import 'dart:convert';

import 'package:chat/core/constants/api_constant.dart';
import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/config/app_config.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class InboxWsClient {
  WebSocketChannel? _channel;

  // Data stream
  final StreamController<Map<String, dynamic>> _messageController = 
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  bool _isManuallyClosed = false;
  int _reconnectAttemtps = 0;
  Timer? _reconnectTimer; 



  String get _baseUrlWs => AppConfig.instance?.baseUrlWs ?? "";

  Future<void> initializeSocketClient(String receiverId) async {

    if(kDebugMode){
      print("Initializing client!");
    }

    _isManuallyClosed = false;

    final token = await sl<ITokenStorage>().getAccessToken();

    // print("My token: $token");
    
    try{

      _channel = IOWebSocketChannel.connect(
        Uri.parse("$_baseUrlWs/${ApiConstant.chatInboxWs}$receiverId/"),
        headers: {
          "Authorization": "Bearer $token"
        },
        pingInterval: 20.seconds() // Keeps connection alive
      );

      _reconnectAttemtps = 0;

      _channel?.stream.listen((message){

        final decodedData = jsonDecode(message) as Map<String, dynamic>;
        _messageController.add(decodedData);

        print("Data send to server: $decodedData");

      },
      onError: (error){
        if(kDebugMode){
          print("Websocket error $error");
        }
        _handleReconnect(receiverId);
      },
      onDone: (){
        if(kDebugMode){
          print("Websocket connection closed");
        }
        _handleReconnect(receiverId);
      }
      );
    }catch(e){
      _handleReconnect(receiverId);
    }

  }

  void _handleReconnect(String receiverId){

    if(_isManuallyClosed) return;

    _reconnectTimer?.cancel();

    _reconnectAttemtps++;

    int delay = (1 << _reconnectAttemtps).clamp(1, 45);

    if (kDebugMode) {
      print("WS Disconnected. Retrying in $delay seconds...");
    }

    _reconnectTimer = Timer(Duration(seconds: delay), () {
      initializeSocketClient(receiverId);
    });
  }

  void sendMessage(Map<String, dynamic> data){
    _channel?.sink.add(jsonEncode(data));
  }

  void dispose(){
    _isManuallyClosed = true;
    _messageController.close();
    _channel?.sink.close();
  }

}