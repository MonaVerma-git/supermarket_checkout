import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/domain/repositories/pricing_repository.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PricingRepository repository;

  CheckoutCubit(this.repository)
      : super(CheckoutState(cartItems: [], totalItemCount: 0));

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
      final totalItemCount = await repository.getTotalItemCount();
      emit(CheckoutState(cartItems: cartItems, totalItemCount: totalItemCount));
    } catch (e) {
      // Handle potential errors
      print("Error updating state: $e");
    }
  }
}
