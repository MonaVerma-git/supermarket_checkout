import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/calculate_totol.dart';
import '../../domain/usecases/scan_item.dart';

class CheckoutCubit extends Cubit<int> {
  final CalculateTotal calculateTotal;
  final ScanItem scanItem;

  CheckoutCubit(this.calculateTotal, this.scanItem) : super(0);

  void scan(String sku) {
    scanItem.call(sku);
    _calculateTotal();
  }

  void _calculateTotal() async {
    final total = await calculateTotal.call(scanItem.scannedItems);
    emit(total);
  }
}
