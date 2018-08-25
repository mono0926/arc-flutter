import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sandbox/bloc/arc_bloc.dart';
import 'package:sandbox/bloc/bloc_provider.dart';

class ArcSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArcBloc>(context);
    return StreamBuilder<double>(
      stream: bloc.value,
      builder: (context, snap) => Slider(
            value: snap.data ?? 0.0,
            onChanged: bloc.valueUpdater.add,
            min: 0.0,
            max: math.pi * 4,
          ),
    );
  }
}
