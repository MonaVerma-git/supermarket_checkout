import '../../../../core/usecase.dart';
import '../entities/promotion.dart';
import '../repositories/pricing_repository.dart';

class CalculateTotal extends UseCase<int, List<String>> {
  final PricingRepository repository;

  CalculateTotal(this.repository);

  @override
  Future<int> call(List<String> scannedItems) async {
    final items = repository.getItems();
    final promotions = repository.getPromotions();

    Map<String, int> skuCount = {};
    for (var sku in scannedItems) {
      skuCount[sku] = (skuCount[sku] ?? 0) + 1;
    }

    int total = 0;

    // Apply promotions
    for (var promotion in promotions) {
      if (promotion.type == PromotionType.multipriced) {
        final sku = promotion.items[0];
        final quantity = skuCount[sku] ?? 0;

        final bundleCount = quantity ~/ promotion.quantity;
        total += bundleCount * promotion.specialPrice;

        skuCount[sku] = quantity % promotion.quantity;
      } else if (promotion.type == PromotionType.buyNGetOneFree) {
        final sku = promotion.items[0];
        final quantity = skuCount[sku] ?? 0;

        final freeItems = quantity ~/ (promotion.quantity + 1);
        total += (quantity - freeItems) *
            items.firstWhere((item) => item.sku == sku).price;

        skuCount[sku] = 0;
      } else if (promotion.type == PromotionType.mealDeal) {
        final dCount = skuCount['D'] ?? 0;
        final eCount = skuCount['E'] ?? 0;

        final bundleCount = dCount < eCount ? dCount : eCount;
        total += bundleCount * promotion.specialPrice;

        skuCount['D'] = dCount - bundleCount;
        skuCount['E'] = eCount - bundleCount;
      }
    }

    // Add remaining items
    skuCount.forEach((sku, count) {
      final price = items.firstWhere((item) => item.sku == sku).price;
      total += count * price;
    });

    return total;
  }
}
