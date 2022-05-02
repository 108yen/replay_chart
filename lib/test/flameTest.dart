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

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
          position.x, position.y, position.x + size.x, position.y + size.y),
      paint,
    );
  }
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await add(MyCrate());

    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
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
      y: 200,
      width: 200,
      height: 200,
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
