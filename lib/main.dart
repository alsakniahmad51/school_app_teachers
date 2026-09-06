import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/core/services/token_storage.dart';

import 'package:teachers_app/features/splash/presentation/splash_page.dart';
import 'package:teachers_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final token = await savedToken();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(SchoolApp(isAuthenticated: token != null));
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key, required this.isAuthenticated});
  final bool isAuthenticated;
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
      home: SplashPage(isAuthenticated: isAuthenticated),
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<String?> savedToken() async {
  return TokenStorage.getToken();
}
