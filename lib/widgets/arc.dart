import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sandbox/bloc/arc_bloc.dart';
import 'package:sandbox/bloc/bloc_provider.dart';

class Arc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArcBloc>(context);
    return LayoutBuilder(builder: (context, constraints) {
      final radius =
          (math.min(constraints.maxWidth, constraints.maxHeight) / 2.0 - 8.0);
      return StreamBuilder<double>(
          initialData: 0.0,
          stream: bloc.value,
          builder: (context, snap) {
            final x = math.cos(snap.data);
            final y = math.sin(snap.data);
            return Stack(
              children: <Widget>[
                _buildHorizontalLine(),
                _buildVerticalLine(),
                _buildArc(),
                _buildPoint(
                  radius: radius,
                  x: x,
                  y: y,
                  maxWidth: constraints.maxWidth,
                  maxHeight: constraints.maxHeight,
                ),
              ],
            );
          });
    });
  }

  Widget _buildPoint({
    double radius,
    double x,
    double y,
    double maxWidth,
    double maxHeight,
  }) {
    return Positioned(
      left: -8.0 + maxWidth / 2.0 + x * radius,
      bottom: -8.0 + maxHeight / 2.0 + y * radius,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
          Positioned(
            left: -8.0,
            bottom: -40.0,
            child: Column(
              children: <Widget>[
                Text('x: ${x.toStringAsFixed(2)}'),
                Text('y: ${y.toStringAsFixed(2)}'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildArc() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
            )),
      ),
    );
  }

  Widget _buildVerticalLine() {
    return Center(
      child: Container(
        width: 1.0,
        color: Colors.black,
      ),
    );
  }

  Widget _buildHorizontalLine() {
    return Center(
      child: Container(
        height: 1.0,
        color: Colors.black,
      ),
    );
  }
}
