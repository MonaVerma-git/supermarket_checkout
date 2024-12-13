import 'package:flutter/widgets.dart';
import '../../../../core/colors.dart';
import '../../domain/entities/promotion.dart';

class PromotionWidget extends StatelessWidget {
  final Promotion promotion;
  const PromotionWidget({super.key, required this.promotion});

  // Handle promotions with switch case
  String promotionText(Promotion promotion) {
    switch (promotion.type) {
      case PromotionType.multipriced:
        return 'Buy ${promotion.requiredQuantity} for £${(promotion.specialPrice / 100)}';

      case PromotionType.buyNGetOneFree:
        return 'Buy ${promotion.requiredQuantity}, get one free';

      case PromotionType.mealDeal:
        return 'Buy D and E for £${(promotion.specialPrice / 100)}';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      promotionText(promotion),
      style: TextStyle(
        color: AppColors.accentColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
}