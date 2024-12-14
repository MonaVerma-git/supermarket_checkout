import 'item.dart';

class CartItem {
  Item item;
  final int count;

  CartItem({required this.item, required this.count});

  CartItem copyWith({Item? item, int? count}) {
    return CartItem(
      item: item ?? this.item,
      count: count ?? this.count,
    );
  }
}
