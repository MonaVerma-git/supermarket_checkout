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

  CheckoutState({required this.cartItems, this.totalItemCount = 0});
}
