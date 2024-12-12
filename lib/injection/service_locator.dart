import 'package:get_it/get_it.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_cubit.dart';
import '../features/checkout/data/repositories/pricing_repository.dart';
import '../features/checkout/domain/repositories/pricing_repository.dart';
import '../features/checkout/domain/usecases/calculate_totol.dart';
import '../features/checkout/domain/usecases/scan_item.dart';
import '../features/checkout/presentation/cubit/checkout_cubit.dart';

final getIt = GetIt.instance;

void initServices() {
  // Register Repository
  getIt.registerLazySingleton<PricingRepository>(() => PricingRepositoryImpl());

  // Register UseCases
  getIt.registerLazySingleton(() => CalculateTotal(getIt()));
  getIt.registerLazySingleton(() => ScanItem());

  // Register Cubit
  getIt.registerFactory(() => CheckoutCubit(getIt(), getIt()));
  getIt.registerFactory(() => ProductListCubit(getIt()));
}
