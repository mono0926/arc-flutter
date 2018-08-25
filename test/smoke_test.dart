// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:sandbox/bloc/arc_bloc.dart';
import 'package:sandbox/bloc/bloc_provider.dart';
import 'package:sandbox/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    final bloc = ArcBloc();
    await tester.pumpWidget(BlocProvider(
      bloc: bloc,
      child: App(),
    ));
    await tester.pump();

    expect(find.text('ラジアン: 0.00 (0.00 π)'), findsOneWidget);
    expect(find.text('x: 1.00'), findsOneWidget);
    expect(find.text('y: 0.00'), findsOneWidget);
    expect(find.text('🍣'), findsOneWidget);

    bloc.valueUpdater.add(9.42);
    await tester.pumpAndSettle();

    expect(find.text('ラジアン: 9.42 (3.00 π)'), findsOneWidget);
    expect(find.text('x: -1.00'), findsOneWidget);
    expect(find.text('y: 0.00'), findsOneWidget);
    expect(find.text('🍨'), findsOneWidget);
  });
}
