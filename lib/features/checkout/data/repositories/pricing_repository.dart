import '../../domain/entities/cart_item.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/repositories/pricing_repository.dart';

class PricingRepositoryImpl implements PricingRepository {
  final List<CartItem> _cart = [];

  @override
  Future<void> addItem(String sku, int price) async {
    final index = _cart.indexWhere((items) => items.item.sku == sku);
    if (index != -1) {
      _cart[index] = CartItem(
          item: Item(sku: sku, price: price), count: _cart[index].count + 1);
    } else {
      _cart.add(CartItem(item: Item(sku: sku, price: price), count: 1));
    }
  }

  @override
  Future<void> removeItem(String sku) async {
    final index = _cart.indexWhere((items) => items.item.sku == sku);
    if (index != -1) {
      if (_cart[index].count > 1) {
        _cart[index] = CartItem(
          item: Item(sku: sku, price: _cart[index].item.price),
          count: _cart[index].count - 1,
        );
      } else {
        _cart.removeAt(index);
      }
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return _cart;
  }

  @override
  Future<int> getTotalItemCount() async {
    int totalCount = 0;
    _cart.forEach((item) {
      totalCount += item.count;
    });
    return totalCount;
  }

  @override
  List<Item> getItems() {
    return [
      Item(
        sku: 'A',
        price: 50,
      ),
      Item(
        sku: 'B',
        price: 75,
        promotion: Promotion(
            type: PromotionType.multipriced,
            requiredQuantity: 2,
            specialPrice: 125),
      ),
      Item(
          sku: 'C',
          price: 25,
          promotion: Promotion(
              type: PromotionType.buyNGetOneFree, requiredQuantity: 3)),
      Item(
        sku: 'D',
        price: 150,
        promotion: Promotion(
            type: PromotionType.mealDeal,
            requiredQuantity: 1,
            comboItems: ['D', 'E'],
            specialPrice: 3),
      ),
      Item(
          sku: 'E',
          price: 200,
          promotion: Promotion(
              type: PromotionType.mealDeal,
              requiredQuantity: 1,
              comboItems: ['D', 'E'],
              specialPrice: 3)),
    ];
  }
}
