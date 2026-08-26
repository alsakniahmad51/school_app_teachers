import 'package:flutter/material.dart';

class AnnouncementItem extends StatelessWidget {
  final String title;
  final String date;

  const AnnouncementItem({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF000F0B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 12, color: Color(0xFF47524F)),
          ),
        ],
      ),
    );
  }
}
