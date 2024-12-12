import '../../../../core/usecase.dart';

class ScanItem extends UseCase<void, String> {
  final List<String> _scannedItems = [];

  @override
  Future<void> call(String params) async {
    _scannedItems.add(params);
  }

  List<String> get scannedItems => _scannedItems;
}
