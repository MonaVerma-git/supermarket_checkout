enum PromotionType { multipriced, buyNGetOneFree, mealDeal }

class Promotion {
  final PromotionType type;
  final List<String> items; // Items
  final int specialPrice;
  final int quantity; // For multipriced or buy n get 1 free

  Promotion({
    required this.type,
    required this.items,
    this.specialPrice = 0, // Default
    this.quantity = 0, // Default
  });
}
