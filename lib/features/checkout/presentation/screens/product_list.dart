import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_cubit.dart';

import '../../../../core/app_colors.dart';
import '../cubit/checkout/checkout_state.dart';
import '../cubit/product_list/product_list_state.dart';
import '../widgets/item_card_widget.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Super Market',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              return IconButton(
                icon: Badge(
                  label: Text(state.totalItemCount.toString()),
                  backgroundColor: AppColors.redColor,
                  child: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                onPressed: () => context.go('/checkout'),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoaded) {
            return GridView.builder(
              itemCount: state.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemCardWidget(
                    item: state.items[index],
                  ),
                );
              },
            );
          } else if (state is ProductListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
      // body: Column(
      //   children: [
      //     // Product List

      //     Padding(
      //       padding: const EdgeInsets.all(12.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const Text(
      //             'Available Items:',
      //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //           ),
      //           const SizedBox(height: 8),
      //           Wrap(
      //             spacing: 10,
      //             runSpacing: 10,
      //             children: skus
      //                 .map(
      //                   (sku) => ElevatedButton(
      //                     style: ElevatedButton.styleFrom(
      //                       padding: const EdgeInsets.symmetric(
      //                           horizontal: 16, vertical: 12),
      //                       backgroundColor: Colors.blueAccent,
      //                     ),
      //                     onPressed: () =>
      //                         context.read<CheckoutCubit>().scan(sku),
      //                     child: Text(
      //                       'Scan Item $sku',
      //                       style: const TextStyle(color: Colors.white),
      //                     ),
      //                   ),
      //                 )
      //                 .toList(),
      //           ),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(height: 20),

      //     // Scanned items list
      //     Expanded(
      //       child: BlocBuilder<CheckoutCubit, int>(
      //         builder: (context, total) {
      //           final scannedItems =
      //               context.read<CheckoutCubit>().scanItem.scannedItems;
      //           return Container(
      //             decoration: BoxDecoration(
      //               color: Colors.grey[100],
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             margin: const EdgeInsets.symmetric(horizontal: 12),
      //             padding: const EdgeInsets.all(12),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const Text(
      //                   'Scanned Items:',
      //                   style: TextStyle(
      //                       fontSize: 18, fontWeight: FontWeight.w600),
      //                 ),
      //                 const Divider(),
      //                 if (scannedItems.isEmpty)
      //                   const Text(
      //                     'No items scanned yet. Start scanning!',
      //                     style: TextStyle(color: Colors.grey),
      //                   ),
      //                 if (scannedItems.isNotEmpty)
      //                   Expanded(
      //                     child: ListView.builder(
      //                       itemCount: scannedItems.length,
      //                       itemBuilder: (context, index) => ListTile(
      //                         leading: CircleAvatar(
      //                           backgroundColor: Colors.green,
      //                           child: Text(
      //                             scannedItems[index],
      //                             style: const TextStyle(color: Colors.white),
      //                           ),
      //                         ),
      //                         title: Text('Item ${scannedItems[index]}'),
      //                       ),
      //                     ),
      //                   ),
      //               ],
      //             ),
      //           );
      //         },
      //       ),
      //     ),

      //     // Total price display
      //     const SizedBox(height: 10),
      //     BlocBuilder<CheckoutCubit, int>(
      //       builder: (context, total) => Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      //         decoration: BoxDecoration(
      //           color: Colors.greenAccent[100],
      //           borderRadius: BorderRadius.circular(10),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black12,
      //               spreadRadius: 1,
      //               blurRadius: 5,
      //             ),
      //           ],
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             const Text(
      //               'Total Price:',
      //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //             ),
      //             Text(
      //               '£${(total / 100).toStringAsFixed(2)}',
      //               style: const TextStyle(
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.green,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),

      //     const SizedBox(height: 10),
      //   ],
      // ),
    );
  }
}
