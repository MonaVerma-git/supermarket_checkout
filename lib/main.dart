import 'package:flutter/material.dart';
import 'package:supermarket/app_routers.dart';
import 'injection/service_locator.dart';

void main() {
  initServices();
  runApp(SuperMarketApp());
}

class SuperMarketApp extends StatelessWidget {
  SuperMarketApp({super.key});
  final AppRouters appRouters = AppRouters();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouters.router,
    );
  }
}
