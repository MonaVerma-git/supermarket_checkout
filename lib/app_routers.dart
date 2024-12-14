import 'package:go_router/go_router.dart';

import 'features/checkout/presentation/screens/checkout_screen.dart';
import 'features/checkout/presentation/screens/product_list.dart';

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
          builder: (context, state) => ProductCheckoutPage(),
        )
      ],
    );
  }
}
