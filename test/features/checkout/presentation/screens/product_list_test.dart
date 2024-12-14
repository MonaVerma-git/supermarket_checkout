import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_state.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:supermarket/features/checkout/presentation/cubit/product_list/product_list_state.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import 'package:supermarket/features/checkout/presentation/screens/product_list.dart';

// Mock Classes
class MockProductListCubit extends MockCubit<ProductListState>
    implements ProductListCubit {}

class MockCheckoutCubit extends MockCubit<CheckoutState>
    implements CheckoutCubit {}

void main() {
  late MockProductListCubit mockProductListCubit;
  late MockCheckoutCubit mockCheckoutCubit;

  setUp(() {
    mockProductListCubit = MockProductListCubit();
    mockCheckoutCubit = MockCheckoutCubit();

    // Mock the stream to return a ProductListLoaded state with some items
    when(() => mockProductListCubit.stream).thenAnswer(
      (_) => Stream.value(ProductListLoaded([
        Item(sku: 'A', price: 50),
        Item(sku: 'B', price: 75),
      ])),
    );

    // Mock loading initial data
    when(() => mockProductListCubit.loadInitialData()).thenAnswer((_) async {});

    // Mock CheckoutCubit's state (e.g., total item count)
    when(() => mockCheckoutCubit.state)
        .thenReturn(CheckoutState(totalItemCount: 2, cartItems: []));
  });

  Widget makeTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductListCubit>(create: (_) => mockProductListCubit),
        BlocProvider<CheckoutCubit>(
          create: (_) => mockCheckoutCubit,
        )
      ],
      child: const MaterialApp(
        home: ProductListPage(),
      ),
    );
  }

  group('ProductListPage with Keys Test', () {
    testWidgets(
        'should display product list when ProductListLoaded state is emitted',
        (tester) async {
      // Arrange: Trigger the widget build process
      await tester.pumpWidget(makeTestableWidget());
      await tester
          .pumpAndSettle(); // Wait for animations and state changes to complete

      // Act & Assert
      // Check if the Scaffold, AppBar, FloatingActionButton, and ProductGrid are present using their keys
      expect(find.byKey(const Key('product_list_scaffold')), findsOneWidget);
      expect(find.byKey(const Key('product_list_app_bar')), findsOneWidget);
      expect(find.byKey(const Key('checkout_fab')), findsOneWidget);
      expect(find.byKey(const Key('checkout_badge')), findsOneWidget);
      expect(find.byKey(const Key('product_grid')), findsOneWidget);
    });

    testWidgets(
        'should show loading indicator when ProductListLoading state is emitted',
        (tester) async {
      // Arrange: Mock the loading state
      when(() => mockProductListCubit.stream).thenAnswer(
        (_) => Stream.value(ProductListLoading()),
      );

      // Act: Trigger the widget build process
      await tester.pumpWidget(makeTestableWidget());
      await tester
          .pumpAndSettle(); // Wait for animations and state changes to complete

      // Act & Assert: Check if the loading indicator is visible
      expect(
          find.byKey(const Key('product_loading_indicator')), findsOneWidget);
    });

    testWidgets('should show error message when an error occurs',
        (tester) async {
      // Arrange: Mock the error state
      when(() => mockProductListCubit.stream).thenAnswer(
        (_) => Stream.value(ProductListError('Something went wrong')),
      );

      // Act: Trigger the widget build process
      await tester.pumpWidget(makeTestableWidget());
      await tester
          .pumpAndSettle(); // Wait for animations and state changes to complete

      // Act & Assert: Check if the error message is visible
      expect(find.byKey(const Key('product_error_message')), findsOneWidget);
    });
  });
}
