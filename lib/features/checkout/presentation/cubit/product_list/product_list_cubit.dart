import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/checkout/domain/repositories/pricing_repository.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final PricingRepository pricingRepository;
  ProductListCubit(this.pricingRepository) : super(ProductListLoading());

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
