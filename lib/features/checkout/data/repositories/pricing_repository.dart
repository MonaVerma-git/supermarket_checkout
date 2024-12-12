import '../../domain/entities/item.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/repositories/pricing_repository.dart';

class PricingRepositoryImpl implements PricingRepository {
  @override
  List<Item> getItems() {
    return [
      Item(sku: 'A', price: 50),
      Item(sku: 'B', price: 75),
      Item(sku: 'C', price: 25),
      Item(sku: 'D', price: 150),
      Item(sku: 'E', price: 200),
    ];
  }

  @override
  List<Promotion> getPromotions() {
    return [
      Promotion(
          type: PromotionType.multipriced,
          items: ['A'],
          specialPrice: 130,
          quantity: 3),
      Promotion(
          type: PromotionType.multipriced,
          items: ['B'],
          specialPrice: 125,
          quantity: 2),
      Promotion(
          type: PromotionType.buyNGetOneFree,
          items: ['C'],
          specialPrice: 0,
          quantity: 3),
      Promotion(
          type: PromotionType.mealDeal, items: ['D', 'E'], specialPrice: 300),
    ];
  }
}
