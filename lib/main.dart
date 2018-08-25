import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sandbox/bloc/arc_bloc.dart';
import 'package:sandbox/bloc/bloc_provider.dart';
import 'package:sandbox/widgets/arc.dart';
import 'package:sandbox/widgets/arc_slider.dart';

void main() => runApp(
      BlocProvider(
        bloc: ArcBloc(),
        child: App(),
      ),
    );

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Math'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Arc(),
                  ),
                ),
                _buildValueText(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 32.0,
                  ),
                  child: ArcSlider(),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildValueText(BuildContext context) {
    final bloc = BlocProvider.of<ArcBloc>(context);
    return StreamBuilder<double>(
      initialData: 0.0,
      stream: bloc.value,
      builder: (context, snap) =>
          Text('ラジアン: ${snap.data.toStringAsFixed(2)} (${(snap.data /
              math.pi).toStringAsFixed(2)} π)'),
    );
  }
}
