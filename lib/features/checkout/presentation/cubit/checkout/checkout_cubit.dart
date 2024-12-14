import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/domain/entities/promotion.dart';
import 'package:supermarket/features/checkout/domain/repositories/pricing_repository.dart';
import 'package:supermarket/features/checkout/domain/usecases/calculate_total.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PricingRepository repository;
  final CalculateTotalPriceUseCase calculateTotalPriceUseCase;

  CheckoutCubit(this.repository, this.calculateTotalPriceUseCase)
      : super(CheckoutState(cartItems: [], totalItemCount: 0, totalPrice: 0));

  // Add Item to Cart
  Future<void> addItem(String sku, int price) async {
    try {
      await repository.addItem(sku, price);
      await _updateState(); // Ensure state is updated after async call
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  // Remove Item from Cart
  Future<void> removeItem(String sku) async {
    try {
      await repository.removeItem(sku);
      await _updateState(); // Ensure state is updated after async call
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  // Update State with the latest cart items and total count
  Future<void> _updateState() async {
    try {
      final cartItems = await repository.getCartItems();
      int totalItemCount = await repository.getTotalItemCount();
      final items = repository.getItems();
      int totalPrice = await calculateTotalPriceUseCase.call(items);

      int productPrice = 0;
      int discountPrice = 0;

      for (var product in cartItems) {
        productPrice += product.item.price * product.count;
        // If the product does not already have a promotion, try to match one
        if (product.item.promotion == null) {
          final matchedItem =
              items.firstWhere((item) => item.sku == product.item.sku);

          product.item =
              product.item.copyWith(promotion: matchedItem.promotion);
        }
      }

      if (productPrice != totalPrice) {
        discountPrice = productPrice - totalPrice;
      }

      for (var product in cartItems) {
        if (product.item.promotion != null &&
            product.item.promotion?.type == PromotionType.buyNGetOneFree) {
          totalPrice = productPrice;
          productPrice += discountPrice;
        }
      }

      emit(CheckoutState(
          cartItems: cartItems,
          totalItemCount: totalItemCount,
          totalPrice: totalPrice,
          productPrice: productPrice,
          discount: discountPrice));
    } catch (e) {
      throw ("Error updating state: $e");
    }
  }
}
