import '../entities/item.dart';

import '../entities/cart_item.dart';
import '../entities/promotion.dart';
import '../repositories/pricing_repository.dart';

class CalculateTotalPriceUseCase {
  final PricingRepository repository;

  CalculateTotalPriceUseCase(this.repository);

  Future<int> call(List<Item> rules) async {
    final cartItems = await repository.getCartItems();
    int totalPrice = 0;

    final skuCounts = _getSkuCounts(cartItems);

    // Process Meal Deal First
    totalPrice += _applyMealDeal(skuCounts, rules);

    // Process other promotions
    skuCounts.forEach((sku, count) {
      final rule = rules.firstWhere((r) => r.sku == sku);
      totalPrice += _calculateItemPrice(sku, count, rule);
    });

    return totalPrice;
  }

  /// Returns a map of SKU counts for all items in the cart
  Map<String, int> _getSkuCounts(List<CartItem> cartItems) {
    final Map<String, int> skuCounts = {};
    for (final item in cartItems) {
      skuCounts[item.item.sku] = (skuCounts[item.item.sku] ?? 0) + item.count;
    }
    return skuCounts;
  }

  /// Apply Meal Deals logic and deduct SKUs counted in the deal
  int _applyMealDeal(Map<String, int> skuCounts, List<Item> rules) {
    const String skuD = 'D';
    const String skuE = 'E';

    if (skuCounts.containsKey(skuD) && skuCounts.containsKey(skuE)) {
      final int countD = skuCounts[skuD] ?? 0;
      final int countE = skuCounts[skuE] ?? 0;

      final int bundleCount =
          countD < countE ? countD : countE; // Take the minimum count
      skuCounts[skuD] = countD - bundleCount;
      skuCounts[skuE] = countE - bundleCount;

      return bundleCount * 300; // Meal deal price: £3 = 300 pence
    }
    return 0;
  }

  /// Calculate item price based on the promotion rules
  int _calculateItemPrice(String sku, int count, Item rule) {
    if (rule.promotion == null) return rule.price * count;

    final promotion = rule.promotion!;
    switch (promotion.type) {
      case PromotionType.multipriced:
        return _applyMultiPricedPromotion(count, promotion, rule.price);
      case PromotionType.buyNGetOneFree:
        return _applyBuyNGetOneFree(count, promotion, rule.price);
      default:
        return rule.price * count;
    }
  }

  /// Apply Multipriced Promotion: Buy n items for a special price
  int _applyMultiPricedPromotion(
      int count, Promotion promotion, int unitPrice) {
    final discountedSets = (count / promotion.requiredQuantity).floor();
    final remainingItems = count % promotion.requiredQuantity;
    return (discountedSets * promotion.specialPrice) +
        (remainingItems * unitPrice);
  }

  /// Apply Buy n Get 1 Free Promotion
  int _applyBuyNGetOneFree(int count, Promotion promotion, int unitPrice) {
    final chargeableCount = (count / promotion.requiredQuantity).floor() *
            (promotion.requiredQuantity - 1) +
        (count % promotion.requiredQuantity);
    return chargeableCount * unitPrice;
  }
}
