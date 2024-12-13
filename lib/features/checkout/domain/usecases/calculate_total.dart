// // ignore_for_file: avoid_renaming_method_parameters

// import '../../../../core/usecase.dart';
// import '../entities/promotion.dart';
// import '../repositories/pricing_repository.dart';

// class CalculateTotal extends UseCase<int, List<String>> {
//   final PricingRepository repository;

//   CalculateTotal(this.repository);

//   @override
//   Future<int> call(List<String> scannedItems) async {
//     final items = repository.getItems();
//     final promotions = repository.getPromotions();

//     // Map sku counts
//     Map<String, int> skuCount = {};
//     for (var sku in scannedItems) {
//       skuCount[sku] = (skuCount[sku] ?? 0) + 1;
//     }

//     int total = 0;

//     // Apply promotions
//     for (var promotion in promotions) {
//       if (promotion.type == PromotionType.multipriced &&
//           promotion.requiredQuantity > 0) {
//         final sku = promotion.items?[0];
//         final quantity = skuCount[sku] ?? 0;

//         final bundleCount = (quantity / promotion.requiredQuantity).floor();
//         total += bundleCount * promotion.specialPrice;

//         skuCount[sku ?? ''] = quantity % promotion.requiredQuantity;
//       } else if (promotion.type == PromotionType.buyNGetOneFree) {
//         final sku = promotion.items?[0];
//         final quantity = skuCount[sku] ?? 0;

//         final freeItems = (quantity / (promotion.requiredQuantity + 1)).floor();
//         total += (quantity - freeItems) *
//             items.firstWhere((item) => item.sku == sku).price;

//         skuCount[sku ?? ''] = 0;
//       } else if (promotion.type == PromotionType.mealDeal) {
//         final dCount = skuCount['D'] ?? 0;
//         final eCount = skuCount['E'] ?? 0;

//         final bundleCount = dCount < eCount ? dCount : eCount;
//         total += bundleCount * promotion.specialPrice;

//         skuCount['D'] = dCount - bundleCount;
//         skuCount['E'] = eCount - bundleCount;
//       }
//     }

//     // Add remaining items
//     skuCount.forEach((sku, count) {
//       final price = items.firstWhere((item) => item.sku == sku).price;
//       total += count * price;
//     });

//     return total;
//   }
// }

import 'package:supermarket/features/checkout/domain/entities/item.dart';

import '../entities/cart_item.dart';
import '../entities/promotion.dart';
import '../repositories/pricing_repository.dart';

class CalculateTotalPriceUseCase {
  final PricingRepository repository;

  CalculateTotalPriceUseCase(this.repository);

  Future<int> call(List<Item> rules) async {
    final cartItems = await repository.getCartItems();
    int totalPrice = 0;

    for (final item in cartItems) {
      final rule = rules.firstWhere((r) => r.sku == item.sku);
      totalPrice += _calculateItemPrice(item, rule);
    }
    return totalPrice;
  }

  int _calculateItemPrice(CartItem item, Item rule) {
    if (rule.promotion == null) return item.unitPrice * item.count;

    final promotion = rule.promotion!;
    switch (promotion.type) {
      case PromotionType.multipriced:
        int discountedSets = (item.count / promotion.requiredQuantity).floor();
        int remainingItems = item.count % promotion.requiredQuantity;
        return (discountedSets * promotion.specialPrice) +
            (remainingItems * item.unitPrice);
      case PromotionType.buyNGetOneFree:
        int chargeableCount =
            (item.count / promotion.requiredQuantity).floor() *
                    (promotion.requiredQuantity - 1) +
                (item.count % promotion.requiredQuantity);
        return chargeableCount * item.unitPrice;
      default:
        return item.unitPrice * item.count;
    }
  }
}
