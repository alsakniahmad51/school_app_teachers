import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Image.asset('assets/images/logo.png', height: 100, width: 132),
        const SizedBox(height: 16),
        const Text(
          'تسجيل الدخول',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "سجل دخولك الآن وابدأ العمل بسلاسة مطلقة",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF5E5E5E),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
