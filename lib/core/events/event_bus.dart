import 'dart:async';

import 'package:chat/core/events/i_event_bus.dart';

class EventBus {

  // Broadcast stream allows multiple listeners
  final _controller = StreamController<dynamic>.broadcast();

  // The publisher of the event bus
  void publish(IEventBus event) => _controller.add(event);

  // Listen method
  Stream<T> on<T extends IEventBus>(){
    return _controller.stream.where((event) => event is T).cast<T>();   
  }

  // Singleton pattern so the whole app uses the same instance 
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

}