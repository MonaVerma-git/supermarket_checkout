import '../entities/item.dart';
import '../entities/promotion.dart';

abstract class PricingRepository {
  List<Item> getItems();
  List<Promotion> getPromotions();
}
