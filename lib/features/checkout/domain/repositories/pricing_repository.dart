import '../entities/cart_item.dart';
import '../entities/item.dart';

abstract class PricingRepository {
  List<Item> getItems();
  Future<void> addItem(String sku, int price);
  Future<void> removeItem(String sku);
  Future<List<CartItem>> getCartItems();
  Future<int> getTotalItemCount();
}
