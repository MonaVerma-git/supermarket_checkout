import '../../../domain/entities/item.dart';

abstract class ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Item> items;

  ProductListLoaded(this.items);
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);
}
