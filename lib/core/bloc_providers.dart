import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_cubit.dart';
import 'service_locator.dart';

class AppBlocProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<ProductListCubit>(
            create: (_) => getIt<ProductListCubit>()),
        BlocProvider<CheckoutCubit>(
          create: (_) => getIt<CheckoutCubit>(),
        )
      ];
}
