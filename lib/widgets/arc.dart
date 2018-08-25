import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sandbox/bloc/arc_bloc.dart';
import 'package:sandbox/bloc/bloc_provider.dart';

class Arc extends StatelessWidget {
  final edge = 24.0;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArcBloc>(context);
    return LayoutBuilder(builder: (context, constraints) {
      final radius =
          (math.min(constraints.maxWidth, constraints.maxHeight) / 2.0 - edge);
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
                  context: context,
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
    BuildContext context,
    double radius,
    double x,
    double y,
    double maxWidth,
    double maxHeight,
  }) {
    final pointSize = 48.0;
    return Positioned(
      left: -pointSize / 2 + maxWidth / 2.0 + x * radius,
      bottom: -pointSize / 2 + maxHeight / 2.0 + y * radius,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: pointSize,
            height: pointSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
              child: StreamBuilder<String>(
                stream: BlocProvider.of<ArcBloc>(context).text,
                builder: (context, snap) => Text(
                      snap.data ?? '',
                      style: TextStyle(fontSize: 32.0),
                    ),
              ),
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
        margin: EdgeInsets.all(edge),
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
