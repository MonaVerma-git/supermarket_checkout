// class CheckoutState {
//   final bool isLoading;
//   final String? error;

//   const CheckoutState({
//     this.isLoading = false,
//     this.error,
//   });

//   CheckoutState copyWith({
//     bool? isLoading,
//     String? error,
//   }) {
//     return CheckoutState(
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }
// }
import '../../../domain/entities/cart_item.dart';

class CheckoutState {
  final List<CartItem> cartItems;
  final int totalItemCount;
  final int totalPrice;
  int productPrice;
  int discount;

  CheckoutState(
      {required this.cartItems,
      this.totalItemCount = 0,
      this.totalPrice = 0,
      this.productPrice = 0,
      this.discount = 0});
}
