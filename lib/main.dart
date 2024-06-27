import 'package:flutter/material.dart';
import 'package:gonime_ca_bloc_tdd/core/injection/injection.dart';
import 'package:gonime_ca_bloc_tdd/core/routings/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoNime',
      theme: ThemeData.light(useMaterial3: true),
      routes: appRoutes,
    );
  }
}
