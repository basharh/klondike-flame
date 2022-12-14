import 'package:meta/meta.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

Sprite klondikeSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('klondike-sprites.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}

@immutable
class Suit {
  static final List<Suit> _singletons = [
    Suit._(0, '♥', 1176, 17, 172, 183),
    Suit._(1, '♦', 973, 14, 177, 182),
    Suit._(2, '♣', 974, 226, 184, 172),
    Suit._(3, '♠', 1178, 220, 176, 182),
  ];

  factory Suit.fromInt(int index) {
    assert(index >= 0 && index <= 3);
    return _singletons[index];
  }

  Suit._(this.value, this.label, double x, double y, double w, double h)
      : sprite = klondikeSprite(x, y, w, h);

  final int value;
  final String label;
  final Sprite sprite;

  /// Hearts and Diamonds are red, while Clubs and Spades are black.
  bool get isRed => value <= 1;
  bool get isBlack => value >= 2;
}
