import 'package:flutter/material.dart';
import 'package:teachers_app/core/functions/navigation.dart';
import 'package:teachers_app/features/ads/presentation/pages/ads_page.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigationWithFade(AdsPage());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 22,
              color: Color(0xFF000F0B),
            ),
          ),
          Positioned(
            top: -5,
            left: -4,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFDC2626),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
