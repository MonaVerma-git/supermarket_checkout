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
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        isExtended: true,
        backgroundColor: AppColors.primaryColor,
        onPressed: () => context.go('/checkout'),
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return Badge(
              label: Text(state.totalItemCount.toString()),
              backgroundColor: AppColors.redColor,
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 30,
              ),
            );
          },
        ),
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
                  padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 10.0),
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
    );
  }
}
