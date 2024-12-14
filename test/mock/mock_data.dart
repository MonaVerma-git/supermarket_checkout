import 'package:mocktail/mocktail.dart';
import 'package:supermarket/features/checkout/domain/repositories/pricing_repository.dart';
import 'package:supermarket/features/checkout/domain/usecases/calculate_total.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_cubit.dart';

// Mock for PricingRepository
class MockPricingRepository extends Mock implements PricingRepository {}

class MockProductListCubit extends Mock implements ProductListCubit {}

// Mock for CalculateTotalPriceUseCase
class MockCalculateTotalPriceUseCase extends Mock
    implements CalculateTotalPriceUseCase {}
