import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:replay_chart/test/flameTest.dart';
import 'package:replay_chart/test/pointerDrawWidget.dart';
import 'package:replay_chart/test/clockView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Home(),
      // home: PointerDrawingWidget(title: 'Pointer drawing lesson'),
      // home:ClockView(),
      home: GameWidget(
        game: myGame,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello world')),
        body: Container(
          width: 400,
          height: 400,
          child: CustomPaint(
            painter: TestCanvas(),
          ),
        ));
  }
}

class TestCanvas extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawRect(Rect.fromLTWH(0, 0, 50, 50), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
