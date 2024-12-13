import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/app_colors.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:supermarket/features/checkout/presentation/widgets/add_remove_widget.dart';

import '../cubit/checkout/checkout_state.dart';
import '../widgets/empty_cart_widget.dart';
import '../widgets/promotion_widget.dart';

class ProductCheckoutPage extends StatelessWidget {
  const ProductCheckoutPage({super.key});

  Widget getItemTotal(String title, int value) => Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 5.0),
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
              value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Checkout',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/product_list'),
          ),
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            print(
                "Checkout State: ${state.cartItems[1].item.promotion?.requiredQuantity} ");
            return state.cartItems.isEmpty
                ? const SizedBox(
                    child: EmptyCartWidget(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = state.cartItems[index].item;
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                    leading: CircleAvatar(
                                        radius: 28,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Text(
                                          item.sku,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                    title: Text(
                                      item.sku,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '£${item.price / 100}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        // item.promotion != null
                                        //     ? PromotionWidget(
                                        //         promotion: item.promotion!)
                                        //     : const SizedBox.shrink(),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 120,
                                      child: AddRemoveWidget(
                                          item: Item(sku: 'A', price: 125)),
                                    )),
                              );
                            }),
                        const SizedBox(height: 30),
                        getItemTotal('Total item', 6),
                        getItemTotal('Price', 6),
                        getItemTotal('Discount', 6),
                        const Divider(),
                        getItemTotal('Total Price', 156),
                      ],
                    ),
                  );
          },
        ));
  }
}
