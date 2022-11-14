import 'package:flame/components.dart';
import 'package:klondike/klondike_game.dart';
import 'package:klondike/components/card/card.dart';
import 'pile.dart';

class WastePile extends PositionComponent implements Pile {
  WastePile({super.position}) : super(size: KlondikeGame.cardSize);

  final List<Card> _cards = [];

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  @override
  void acquireCard(Card card) {
    assert(card.isFaceUp);
    card.position = position;
    card.priority = _cards.length;
    card.pile = this;
    _cards.add(card);
  }

  @override
  bool canAcceptCard(Card card) {
    return false;
  }

  @override
  void returnCard(Card card) {
    card.priority = _cards.indexOf(card);
    _fanOutTopCards();
  }

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
    _fanOutTopCards();
  }

  @override
  bool get debugMode => true;

  void _fanOutTopCards() {
    final n = _cards.length;
    for (var i = 0; i < n; i++) {
      _cards[i].position = position;
    }
    if (n == 2) {
      _cards[1].position.add(_fanOffset);
    } else if (n >= 3) {
      _cards[n - 2].position.add(_fanOffset);
      _cards[n - 1].position.addScaled(_fanOffset, 2);
    }
  }

  List<Card> removeAllCards() {
    final cards = _cards.toList();
    _cards.clear();
    return cards;
  }

  final Vector2 _fanOffset = Vector2(KlondikeGame.cardWidth * 0.2, 0);
}
