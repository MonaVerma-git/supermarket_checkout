enum PromotionType { multipriced, buyNGetOneFree, mealDeal }

class Promotion {
  final PromotionType type;
  final List<String>? comboItems; // Items
  final int specialPrice;
  final int requiredQuantity; // For multipriced or buy n get 1 free

  Promotion({
    required this.type,
    this.comboItems,
    this.specialPrice = 0, // Default
    required this.requiredQuantity, // Default
  });
}
