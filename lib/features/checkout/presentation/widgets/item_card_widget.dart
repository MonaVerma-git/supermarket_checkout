import 'package:flutter/material.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import 'package:supermarket/features/checkout/presentation/widgets/add_remove_widget.dart';
import 'package:supermarket/features/checkout/presentation/widgets/promotion_widget.dart';
import '../../../../core/app_colors.dart';

class ItemCardWidget extends StatelessWidget {
  final Item item;
  const ItemCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(8.0) //                 <--- border radius here
              ),
          border: Border.all(color: AppColors.primaryColor, width: 1)),
      // semanticContainer: true,
      // elevation: 2,
      // color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle Avatar Section
            Expanded(
              flex: 2,
              child: Center(
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    item.sku,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Item Name
            Expanded(
              flex: 1,
              child: Text(
                'Item ${item.sku}',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Price & Add/Remove Controls
            Expanded(
                flex: 1,
                child: Text(
                  '£${(item.price / 100).toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )),
            // Display Promotion if exists
            Expanded(
              flex: 1,
              child: item.promotion != null ||
                      (item.promotion?.comboItems?[0] == item.sku ||
                          item.promotion?.comboItems?[1] == item.sku)
                  ? PromotionWidget(promotion: item.promotion!)
                  : const SizedBox.shrink(),
            ),
            // Quantity Row
            const Divider(),
            Expanded(flex: 2, child: AddRemoveWidget(item: item)),
          ],
        ),
      ),
    );
  }
}
