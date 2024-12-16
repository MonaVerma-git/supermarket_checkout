import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/app_colors.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:supermarket/features/checkout/presentation/widgets/add_remove_widget.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/promotion.dart';
import '../cubit/checkout/checkout_state.dart';
import '../widgets/empty_cart_widget.dart';
import '../widgets/promotion_widget.dart';

class ProductCheckoutPage extends StatelessWidget {
  const ProductCheckoutPage({super.key});

  Widget _buildItemTotal(String title, String value, Key key) => Padding(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      );

  String _getFreeItem(List<CartItem> cartItems) {
    String freeCount = '0';
    for (var product in cartItems) {
      final promotion = product.item.promotion;
      if (promotion != null &&
          promotion.requiredQuantity > 0 &&
          promotion.type == PromotionType.buyNGetOneFree) {
        freeCount +=
            (product.count / promotion.requiredQuantity).floor().toString();
      }
    }
    return freeCount.toString();
  }

  Widget _buildSummaryHeader(String title) {
    return Container(
      key: const Key('checkout_summary_header'),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('checkout_app_bar'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          key: const Key('checkout_back_button'),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/product_list'),
        ),
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return state.cartItems.isEmpty
              ? const EmptyCartWidget(key: Key('empty_cart_widget'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        key: const Key('checkout_list_view'),
                        shrinkWrap: true,
                        itemCount: state.cartItems.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = state.cartItems[index].item;

                          return ListTile(
                            contentPadding: const EdgeInsets.all(5.0),
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                item.sku,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(
                              item.sku,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '£${item.price / 100}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                item.promotion != null
                                    ? PromotionWidget(
                                        promotion: item.promotion!)
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 120,
                              child: AddRemoveWidget(item: item),
                            ),
                          );
                        },
                      ),
                      _buildSummaryHeader('Price Total'),
                      const SizedBox(height: 12),
                      _buildItemTotal(
                          'Total item',
                          state.totalItemCount.toString(),
                          const Key('checkout_total_items')),
                      _buildItemTotal(
                          'Free item',
                          _getFreeItem(state.cartItems),
                          const Key('checkout_free_items')),
                      _buildItemTotal('Price', '£${(state.productPrice / 100)}',
                          const Key('checkout_product_price')),
                      _buildItemTotal(
                          'Discount',
                          state.discount > 0
                              ? '-£${(state.discount / 100)}'
                              : '0.0',
                          const Key('checkout_discount')),
                      const Divider(),
                      _buildItemTotal(
                          'Total Price',
                          '£${(state.totalPrice / 100)}',
                          const Key('checkout_total_price')),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
