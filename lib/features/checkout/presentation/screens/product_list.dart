import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/checkout/checkout_cubit.dart';
import '../cubit/product_list/product_list_cubit.dart';

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
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(context),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          return state is ProductListLoaded
              ? _buildProductGrid(state)
              : _buildLoadingOrErrorState(state);
        },
      ),
    );
  }

  /// App Bar Widget
  AppBar _buildAppBar() {
    return AppBar(
      key: const Key('product_list_app_bar'),
      title: const Text(
        'Super Market',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
    );
  }

  /// Floating Action Button
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      key: const Key('checkout_fab'),
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
    );
  }

  /// Product Grid View
  Widget _buildProductGrid(ProductListLoaded state) {
    return GridView.builder(
      key: const Key('product_grid'),
      itemCount: state.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 10.0),
          child: ItemCardWidget(
            key: const Key('product_item'),
            item: state.items[index],
          ),
        );
      },
    );
  }

  /// Handles Loading and Error States
  Widget _buildLoadingOrErrorState(ProductListState state) {
    if (state is ProductListLoading) {
      return const Center(
        key: Key('product_loading_indicator'),
        child: CircularProgressIndicator(),
      );
    }
    return const Center(
      key: Key('product_error_message'),
      child: Text('Something went wrong'),
    );
  }
}
