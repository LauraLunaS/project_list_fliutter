import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project_list_fliutter/src/app_widget.dart';
import 'package:project_list_fliutter/src/modules/auth_module.dart';

void main() {
  runApp(
    ModularApp(
      module: AuthModule(),
      child: const AppWidget(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
