import 'package:supermarket/features/checkout/domain/entities/promotion.dart';

class Item {
  final String sku;
  final int price;
  final Promotion? promotion;

  Item({required this.sku, required this.price, this.promotion});
}
