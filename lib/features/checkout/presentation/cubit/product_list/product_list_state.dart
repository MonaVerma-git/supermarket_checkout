import 'package:supermarket/features/checkout/domain/entities/promotion.dart';

import '../../../domain/entities/item.dart';

abstract class ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Item> items;
  final List<Promotion> promotionItems;

  ProductListLoaded(this.items, this.promotionItems);
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);
}
