import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primaryColor,
            size: 150,
          ),
          onPressed: () {},
        ),
        const ListTile(
          title: Center(
            child: Text(
              'Oppss!',
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          subtitle: Center(
            child: Text(
              'Sorry, you have no product in your card',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
