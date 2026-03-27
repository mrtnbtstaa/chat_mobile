import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

abstract class CoreTransformers {
  // Debounce events to prevent spam and restartable execution
  // to ensure only the latest event is processed
  static EventTransformer<E> debounceRestartable<E>(Duration duration){
    return (events, mapper){
      return restartable<E>()(
        events.debounce(duration),
        mapper
      );
    };
  }

}