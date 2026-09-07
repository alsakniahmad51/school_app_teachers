import 'package:flutter/material.dart';
import 'package:teachers_app/features/home/presentation/widgets/notification_icon.dart';

import 'home_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.teacherName});
  final String teacherName;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HomeColors.surface,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          ProfileAvatar(),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "أ.${teacherName}",
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
          NotificationIcon(),
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
        "أ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
