import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import '../../../../core/color.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/promotion.dart';
import '../cubit/checkout/checkout_state.dart';

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

  // Handle promotions with switch case
  String promotion(Promotion promotion) {
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
    final checkoutCubit = context.read<CheckoutCubit>();

    return Card(
      semanticContainer: true,
      elevation: 2,
      color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            // Find the item count in the cart for the current item SKU
            final cartItem = state.cartItems.firstWhere(
              (product) => product.sku == items.sku,
              orElse: () => CartItem(
                sku: items.sku,
                unitPrice: items.price,
                count: 0,
              ),
            );
            final itemCount = cartItem.count;

            return Column(
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
                        items.sku,
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
                    'Item ${items.sku}',
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
                      '£${(items.price / 100).toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: AppColors.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    )),
                // Display Promotion if exists
                Expanded(
                  flex: 1,
                  child: items.promotion != null
                      ? Text(
                          promotion(items.promotion!),
                          style: TextStyle(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                // Quantity Row
                const Divider(),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Remove Button
                      InkWell(
                        child: cardIcon('remove'),
                        onTap: () {
                          checkoutCubit.removeItem(items.sku);
                        },
                      ),
                      // Count Text
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          itemCount.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Add Button
                      InkWell(
                        child: cardIcon('add'),
                        onTap: () {
                          checkoutCubit.addItem(items.sku, items.price);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
