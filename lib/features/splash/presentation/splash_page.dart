import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/core/manager/fcm_cubit/fcm_cubit.dart';
import 'package:teachers_app/features/auth/presentation/pages/login_page.dart';
import 'package:teachers_app/features/home/data/datasources/sections_remote_data_source.dart';
import 'package:teachers_app/features/home/data/repo/sections_repository_impl.dart';
import 'package:teachers_app/features/home/domain/usecases/get_teacher_sections_use_case.dart';
import 'package:teachers_app/features/home/presentation/manager/teacher_sections_cubit.dart/teacher_sections_cubit.dart';

import '../../home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.isAuthenticated});
  final bool isAuthenticated;
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
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
            child: widget.isAuthenticated ? HomePage() : LoginPage(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF007353),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/splash_logo.svg',
              width: 132,
              height: 132,
            ),
            SizedBox(height: 18),
            SvgPicture.asset(
              'assets/images/scondary_logo.svg',
              width: 146,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
