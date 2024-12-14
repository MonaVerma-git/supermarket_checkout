import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import 'package:supermarket/features/checkout/domain/entities/promotion.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';

import '../../../../core/app_colors.dart';
import '../../domain/entities/cart_item.dart';
import '../cubit/checkout/checkout_state.dart';

class AddRemoveWidget extends StatelessWidget {
  final Item item;
  const AddRemoveWidget({super.key, required this.item});

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
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        // Access CheckoutCubit from the context
        final checkoutCubit = context.read<CheckoutCubit>();

        final cartItem = state.cartItems.firstWhere(
          (product) => product.item.sku == item.sku,
          orElse: () => CartItem(
            item: Item(
                sku: item.sku, price: item.price, promotion: item.promotion),
            count: 0,
          ),
        );
        final itemCount = cartItem.count;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Remove Button
            InkWell(
              child: cardIcon('remove'),
              onTap: () {
                checkoutCubit.removeItem(item.sku);
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
                  checkoutCubit.addItem(item.sku, item.price);
                }),
          ],
        );
      },
    );
  }
}
