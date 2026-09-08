import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teachers_app/core/manager/fcm_cubit/fcm_cubit.dart';
import 'package:teachers_app/features/auth/presentation/pages/login_page.dart';

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
    _initFcm();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => widget.isAuthenticated ? HomePage() : LoginPage(),
        ),
      );
    });
  }

  Future<void> _initFcm() async {
    final fcmCubit = context.read<FcmCubit>();

    await fcmCubit.init(true, null);
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
