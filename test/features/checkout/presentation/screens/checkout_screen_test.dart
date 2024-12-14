import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supermarket/features/checkout/domain/entities/cart_item.dart';
import 'package:supermarket/features/checkout/domain/entities/item.dart';
import 'package:supermarket/features/checkout/domain/entities/promotion.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:supermarket/features/checkout/presentation/cubit/checkout/checkout_state.dart';
import 'package:supermarket/features/checkout/presentation/screens/checkout_screen.dart';

class MockCheckoutCubit extends Mock implements CheckoutCubit {}

void main() {
  late MockCheckoutCubit mockCheckoutCubit;

  setUp(() {
    mockCheckoutCubit = MockCheckoutCubit();
  });

  Widget makeTestableWidget(CheckoutCubit cubit) {
    return MaterialApp(
      home: BlocProvider<CheckoutCubit>(
        create: (_) => cubit,
        child: const ProductCheckoutPage(),
      ),
    );
  }

  group('ProductCheckoutPage Tests', () {
    testWidgets('displays EmptyCartWidget when cart is empty', (tester) async {
      // Arrange: Mock the CheckoutCubit state with an empty cart
      when(() => mockCheckoutCubit.state).thenReturn(
        CheckoutState(
            cartItems: [],
            totalItemCount: 0,
            productPrice: 0,
            discount: 0,
            totalPrice: 0),
      );

      // Act: Render the widget
      await tester.pumpWidget(makeTestableWidget(mockCheckoutCubit));

      // Assert: Verify EmptyCartWidget is displayed
      expect(find.byKey(const Key('empty_cart_widget')), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('displays checkout items and summary correctly',
        (tester) async {
      // Arrange: Mock cart items with promotions and totals
      final mockCartItems = [
        CartItem(
          item: Item(
            sku: 'A',
            price: 5000,
            promotion: Promotion(
                type: PromotionType.buyNGetOneFree, requiredQuantity: 3),
          ),
          count: 3,
        ),
        CartItem(
          item: Item(
            sku: 'B',
            price: 3000,
            promotion: null,
          ),
          count: 2,
        ),
      ];

      when(() => mockCheckoutCubit.state).thenReturn(
        CheckoutState(
          cartItems: mockCartItems,
          totalItemCount: 5,
          productPrice: 20000,
          discount: 5000,
          totalPrice: 15000,
        ),
      );

      // Act: Render the widget
      await tester.pumpWidget(makeTestableWidget(mockCheckoutCubit));

      // Assert: Verify the list view and items
      expect(find.byKey(const Key('checkout_list_view')), findsOneWidget);

      // Check Summary section
      expect(find.byKey(const Key('checkout_summary_header')), findsOneWidget);
      expect(find.byKey(const Key('checkout_total_items')), findsOneWidget);

      expect(find.byKey(const Key('checkout_free_items')), findsOneWidget);

      expect(find.byKey(const Key('checkout_product_price')), findsOneWidget);

      expect(find.byKey(const Key('checkout_discount')), findsOneWidget);

      expect(find.byKey(const Key('checkout_total_price')), findsOneWidget);
    });
  });
}
