import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/core/manager/fcm_cubit/fcm_cubit.dart';
import 'package:teachers_app/core/services/token_storage.dart';
import 'package:teachers_app/features/home/data/datasources/sections_remote_data_source.dart';
import 'package:teachers_app/features/home/data/repo/sections_repository_impl.dart';
import 'package:teachers_app/features/home/domain/usecases/get_teacher_sections_use_case.dart';
import 'package:teachers_app/features/home/presentation/manager/teacher_sections_cubit.dart/teacher_sections_cubit.dart';

import 'package:teachers_app/features/splash/presentation/splash_page.dart';
import 'package:teachers_app/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final token = await savedToken();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FcmCubit()),
        BlocProvider(
          create: (context) => TeacherSectionsCubit(
            GetTeacherSectionsUseCase(
              SectionsRepositoryImpl(
                SectionsRemoteDataSourceImpl(DioConsumer(dio: Dio())),
              ),
            ),
          ),
        ),
      ],
      child: SchoolApp(isAuthenticated: token != null),
    ),
  );
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
