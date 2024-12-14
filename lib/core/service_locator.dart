import 'package:get_it/get_it.dart';
import '../features/checkout/presentation/cubit/product_list/product_list_cubit.dart';
import '../features/checkout/data/repositories/pricing_repository_impl.dart';
import '../features/checkout/domain/repositories/pricing_repository.dart';
import '../features/checkout/domain/usecases/calculate_total.dart';
import '../features/checkout/presentation/cubit/checkout/checkout_cubit.dart';

final getIt = GetIt.instance;

void initServices() {
  // Register Repository
  getIt.registerLazySingleton<PricingRepository>(() => PricingRepositoryImpl());

  // Register UseCases
  getIt.registerLazySingleton<CalculateTotalPriceUseCase>(
      () => CalculateTotalPriceUseCase(getIt()));

  // Register Cubits
  getIt.registerFactory(() => CheckoutCubit(getIt(), getIt()));
  getIt.registerFactory(() => ProductListCubit(getIt(), getIt()));
}
