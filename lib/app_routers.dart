import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/checkout/presentation/cubit/checkout_cubit.dart';
import 'features/checkout/presentation/cubit/product_list/product_list_cubit.dart';
import 'features/checkout/presentation/screens/product_list.dart';
import 'injection/service_locator.dart';

class AppRouters {
  GoRouter get router {
    return GoRouter(
      initialLocation: '/product_list',
      routes: [
        GoRoute(
          path: '/product_list',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<ProductListCubit>(),
            child: const ProductListPage(),
          ),
        ),
        // GoRoute(
        //   path: '/checkout',
        //   builder: (context, state) => BlocProvider(
        //     create: (_) => getIt<CheckoutCubit>(),
        //     child: const ProductListPage(),
        //   ),
        // )
      ],
      // errorBuilder: (context, state) => Error(),
    );
  }
}
