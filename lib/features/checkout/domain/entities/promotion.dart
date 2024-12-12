enum PromotionType { multipriced, buyNGetOneFree, mealDeal }

class Promotion {
  final PromotionType type;
  final List<String> items; // Items involved
  final int specialPrice;
  final int quantity; // For multipriced or buy n get 1 free

  Promotion({
    required this.type,
    required this.items,
    required this.specialPrice,
    this.quantity = 0,
  });
}
