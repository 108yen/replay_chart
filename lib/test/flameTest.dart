import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/timer.dart';
import 'package:charset_converter/charset_converter.dart';

class MyCrate extends SpriteComponent {
  // creates a component that renders the crate.png sprite, with size 16 x 16
  MyCrate() : super(size: Vector2.all(16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('crate.png');
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // We don't need to set the position in the constructor, we can set it
    // directly here since it will be called once before the first time it
    // is rendered.
    position = gameSize / 2;
  }
}

class MyRectangle extends RectangleComponent {
  MyRectangle({double x, double y, double width, double height, Paint paint})
      : super(
            position: Vector2(x, y),
            size: Vector2(width, height),
            paint: paint) {
    interval = Timer(
      0.01,
      onTick: () => moveCircle(),
      repeat: true,
    );
    csvRead();
  }
  double i = 0;
  int r = 100;
  double time = 0;
  Timer interval;

  void moveCircle() {
    if (i < 2 * pi) {
      i += 0.01;
    } else {
      i = 0;
    }
    if (sin(i) <= 0) {
      paint.color = Colors.red;
    } else {
      paint.color = Colors.blue;
    }
  }

  @override
  void update(double dt) {
    interval.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(position.x, position.y, size.x, size.y + sin(i) * r),
      paint,
    );
  }

  void csvRead() {
    final File file =
        new File("/Users/shiraikazuki/workspace/replay_chart/assets/data");

    Stream fread = file.openRead();

    StreamTransformer<List<int>, String> transform() {
      return StreamTransformer<List<int>, String>.fromHandlers(
          handleData: (data, sink) async {
        print(data);
        sink.add(await CharsetConverter.decode('Shift_JIS', data));
      });
    }

    fread
        .transform(transform()) // Decode bytes to UTF-8.
        .transform(new LineSplitter()) // Convert stream to individual lines.
        .listen((String line) {
      // Process results.

      // カンマ区切りで各列のデータを配列に格納
      List rows = line.split(','); // split by comma

      // 1～3列目のデータを取得
      String row1 = rows[0];
      String row2 = rows[1];
      String row3 = rows[2];

      print(row1);
    }, onDone: () {
      print('File is now closed.');
    }, onError: (e) {
      print(e.toString());
    });
  }
}

class MyGame extends FlameGame {
  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    // await add(MyCrate());

    final paint = Paint()..color = Colors.red;

    final myRectangle = MyRectangle(
      x: 200,
      y: 100,
      width: 20,
      height: 20,
      paint: paint,
    );
    add(myRectangle);
  }
}
