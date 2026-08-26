import 'package:flutter/material.dart';
import 'package:teachers_app/features/home/presentation/pages/home_page.dart';
import 'package:teachers_app/features/splash/presentation/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat-Arabic',
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff007353)),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
