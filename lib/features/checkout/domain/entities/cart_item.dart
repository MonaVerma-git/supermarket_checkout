import 'package:supermarket/features/checkout/domain/entities/item.dart';

class CartItem {
  final Item item;
  final int count;

  const CartItem({required this.item, required this.count});

  CartItem copyWith({Item? item, int? count}) {
    return CartItem(
      item: item ?? this.item, // if item is not passed, keep the original
      count: count ?? this.count, // if count is not passed, keep the original
    );
  }
}
