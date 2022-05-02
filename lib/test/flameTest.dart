import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

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
            paint: paint);
  double i = 0;
  int r = 100;
  double time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    i = time / 2;
    if (i > 2 * pi) {
      i = 0;
      time = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
          position.x + cos(i) * r, position.y + sin(i) * r, size.x, size.y),
      paint,
    );
  }
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // await add(MyCrate());

    final paint = Paint()..color = Colors.red;
    // final square = RectangleComponent.square(
    //   size: 200.0,
    //   position: Vector2(100, 200),
    //   paint: paint,
    // );
    // add(square);

    // final rectangle = RectangleComponent(
    //   size: Vector2(300.0, 200.0),
    //   position: Vector2(100, 200),
    //   paint: paint,
    // );
    // add(rectangle);

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

// main() {
//   final myGame = MyGame();
//   runApp(
//     GameWidget(
//       game: myGame,
//     ),
//   );
// }
