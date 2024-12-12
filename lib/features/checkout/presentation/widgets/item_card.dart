import 'package:flutter/material.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import '../../../../core/color.dart';

class ItemCardWidget extends StatelessWidget {
  final Item items;
  const ItemCardWidget({super.key, required this.items});

  Widget cardIcon(String flag) => Container(
        decoration: BoxDecoration(
          color: flag == 'add' ? AppColors.primaryColor : AppColors.redColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          flag == 'add' ? Icons.add : Icons.remove,
          color: AppColors.backgroundColor,
          size: 20,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.borderColor, // Border color
          width: 1, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle Avatar Section
            Center(
              child: CircleAvatar(
                radius: 28, // Responsive radius
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  items.sku,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32, // Responsive font size
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Item Name
            Text(
              'Item ${items.sku}',
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            // Price & add/remove to card
            ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: Text(
                '£${(items.price / 100)}',
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14, // Responsive font size
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Smaller Minus Button
                  InkWell(
                    child: cardIcon('remove'),
                    onTap: () {},
                  ),
                  // Count Text
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    child: cardIcon('add'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Text(
              'Buy 2 get one free',
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12 // Responsive font size
                  ),
            ),
            // Quantity Row
          ],
        ),
      ),
    );
  }
}
