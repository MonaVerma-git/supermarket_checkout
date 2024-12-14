import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/pricing_repository.dart';
import '../../../domain/usecases/calculate_total.dart';
import 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final PricingRepository pricingRepository;
  final CalculateTotalPriceUseCase calculateTotalPriceUseCase;
  ProductListCubit(this.pricingRepository, this.calculateTotalPriceUseCase)
      : super(ProductListLoading());

  Future<void> loadInitialData() async {
    try {
      emit(ProductListLoading());
      final items = pricingRepository.getItems();
      emit(ProductListLoaded(items));
    } catch (error) {
      emit(ProductListError('Something went wrong'));
    }
  }
}
