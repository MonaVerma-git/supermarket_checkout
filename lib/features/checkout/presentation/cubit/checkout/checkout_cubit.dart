import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/pricing_repository.dart';
import '../../../domain/usecases/calculate_total.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/item.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PricingRepository repository;
  final CalculateTotalPriceUseCase calculateTotalPriceUseCase;

  CheckoutCubit(this.repository, this.calculateTotalPriceUseCase)
      : super(CheckoutState(
          cartItems: [],
          totalItemCount: 0,
          totalPrice: 0,
        ));

  /// Adds an item to the cart and updates the state.
  Future<void> addItem(String sku, int price) async =>
      _handleCartUpdate(() => repository.addItem(sku, price));

  /// Removes an item from the cart and updates the state.
  Future<void> removeItem(String sku) async =>
      _handleCartUpdate(() => repository.removeItem(sku));

  /// Helper to handle async updates and state refresh.
  Future<void> _handleCartUpdate(Future<void> Function() updateAction) async {
    try {
      await updateAction();
      await _refreshCartState();
    } catch (e) {
      throw Exception("Error updating cart: $e");
    }
  }

  /// Refreshes the cart state by fetching updated data.
  Future<void> _refreshCartState() async {
    try {
      final cartItems = await repository.getCartItems();
      final totalItemCount = await repository.getTotalItemCount();
      final items = repository.getItems();

      _applyPromotions(cartItems, items);

      final productPrice = _calculateProductPrice(cartItems);
      final totalPrice = await calculateTotalPriceUseCase.call(items);
      final discount = productPrice - totalPrice;

      emit(CheckoutState(
        cartItems: cartItems,
        totalItemCount: totalItemCount,
        productPrice: productPrice,
        totalPrice: totalPrice,
        discount: discount > 0 ? discount : 0,
      ));
    } catch (e) {
      throw Exception("Error refreshing cart state: $e");
    }
  }

  /// Applies promotions to cart items where applicable.
  void _applyPromotions(List<CartItem> cartItems, List<Item> items) {
    for (var product in cartItems) {
      if (product.item.promotion == null) {
        final matchedItem = items.firstWhere(
          (item) => item.sku == product.item.sku,
          orElse: () => product.item,
        );
        product.item = product.item.copyWith(promotion: matchedItem.promotion);
      }
    }
  }

  /// Calculates the total product price without discounts.
  int _calculateProductPrice(List<CartItem> cartItems) {
    return cartItems.fold(
        0, (sum, product) => sum + (product.item.price * product.count));
  }
}
