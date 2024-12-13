// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/usecases/calculate_total.dart';
// import '../../../domain/usecases/scan_item.dart';

// class CheckoutCubit extends Cubit<int> {
//   final CalculateTotal calculateTotal;
//   final ScanItem scanItem;

//   CheckoutCubit(this.calculateTotal, this.scanItem) : super(0);

//   void scan(String sku) {
//     scanItem.call(sku);
//     _calculateTotal();
//   }

//   void _calculateTotal() async {
//     final total = await calculateTotal.call(scanItem.scannedItems);
//     emit(total);
//   }

//   void addItem() => emit(state + 1);
//   void removeItem() {
//     if (state > 0) emit(state - 1);
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/domain/repositories/pricing_repository.dart';

import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PricingRepository repository;

  CheckoutCubit(this.repository) : super(CheckoutState(cartItems: []));

  Future<void> addItem(String sku, int price) async {
    await repository.addItem(sku, price);
    _updateState();
  }

  Future<void> removeItem(String sku) async {
    await repository.removeItem(sku);
    _updateState();
  }

  void _updateState() async {
    final cartItems = await repository.getCartItems();
    final totalItemCount = await repository.getTotalItemCount();
    emit(CheckoutState(cartItems: cartItems, totalItemCount: totalItemCount));
  }
}
