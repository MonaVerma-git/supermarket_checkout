import 'package:flutter/widgets.dart';
import '../../../../core/app_colors.dart';
import '../../domain/entities/promotion.dart';

class PromotionWidget extends StatelessWidget {
  final Promotion promotion;
  const PromotionWidget({super.key, required this.promotion});

  // Handle promotions with switch case
  String _buildPromotionText(Promotion promotion) {
    switch (promotion.type) {
      case PromotionType.multipriced:
        return 'Buy ${promotion.requiredQuantity} for £${(promotion.specialPrice / 100)}';

      case PromotionType.buyNGetOneFree:
        return 'Buy ${promotion.requiredQuantity}, get one free';

      case PromotionType.mealDeal:
        return 'Buy ${promotion.comboItems?[0]} and ${promotion.comboItems?[1]} for £${(promotion.specialPrice / 100)}';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _buildPromotionText(promotion),
      style: TextStyle(
        color: AppColors.accentColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
}
