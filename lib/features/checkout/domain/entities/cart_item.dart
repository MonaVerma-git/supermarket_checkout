import 'package:supermarket/features/checkout/domain/entities/item.dart';

class CartItem {
  Item item;
  final int count;

  CartItem({required this.item, required this.count});

  CartItem copyWith({Item? item, int? count}) {
    return CartItem(
      item: item ?? this.item, // if item is not passed, keep the original
      count: count ?? this.count, // if count is not passed, keep the original
    );
  }
}
