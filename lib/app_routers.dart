import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';

import 'features/checkout/presentation/screens/checkout_screen.dart';
import 'features/checkout/presentation/screens/product_list.dart';
import 'core/service_locator.dart';

class AppRouters {
  GoRouter get router {
    return GoRouter(
      initialLocation: '/product_list',
      routes: [
        GoRoute(
          path: '/product_list',
          builder: (context, state) => const ProductListPage(),
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const ProductCheckoutPage(),
        )
      ],
      // errorBuilder: (context, state) => Error(),
    );
  }
}
