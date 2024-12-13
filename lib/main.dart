import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/app_routers.dart';
import 'package:supermarket/core/bloc_providers.dart';
import 'core/service_locator.dart';

void main() {
  initServices();
  runApp(
    MultiBlocProvider(
      providers: AppBlocProviders.providers,
      child: SuperMarketApp(),
    ),
  );
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
