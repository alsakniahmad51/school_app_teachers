import 'package:flutter/material.dart';

import 'home_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HomeColors.surface,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: const Row(
        children: [
          ProfileAvatar(),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أ. محمد عبد الكريم',
                  style: TextStyle(
                    color: HomeColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Text(
                  'أهلا وسهلاً بك',
                  style: TextStyle(
                    color: HomeColors.secondaryText,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          NotificationButton(),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff006838),
        border: Border.all(color: const Color(0xffcf993f), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'م',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'الإشعارات',
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.notifications_none_outlined, size: 24),
            color: HomeColors.primaryText,
            style: IconButton.styleFrom(
              fixedSize: const Size(40, 40),
              side: const BorderSide(color: HomeColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: HomeColors.critical,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 10, height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
