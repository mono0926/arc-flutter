import 'dart:async';
import 'dart:math' as math;

import 'package:rxdart/rxdart.dart';
import 'package:sandbox/bloc/bloc_provider.dart';

class ArcBloc extends Bloc {
  ArcBloc() {
    _value.listen((value) {
      _text.sink.add(_convertToText(value));
    });
  }

  Stream<double> get value => _value.stream;

  Stream<String> get text => _text.stream;

  Sink<double> get valueUpdater => _value.sink;

  @override
  void dispose() {
    _value.close();
    _text.close();
  }

  final _value = BehaviorSubject<double>(seedValue: 0.0);
  final _text = BehaviorSubject<String>(seedValue: '🍣');

  String _convertToText(double value) {
    if (value < math.pi * 2) {
      return '🍣';
    }
    if (value < math.pi * 4) {
      return '🍨';
    }
    return '🍵';
  }
}
