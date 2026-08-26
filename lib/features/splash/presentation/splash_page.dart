import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

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

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
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
