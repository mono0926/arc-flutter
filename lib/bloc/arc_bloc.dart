import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sandbox/bloc/bloc_provider.dart';

class ArcBloc extends Bloc {
  final _value = BehaviorSubject<double>(seedValue: 0.0);

  Stream<double> get value => _value.stream;

  Sink<double> get valueUpdater => _value.sink;

  @override
  void dispose() {
    _value.close();
  }
}
