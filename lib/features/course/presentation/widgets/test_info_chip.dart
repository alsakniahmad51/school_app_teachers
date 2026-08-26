import 'package:flutter/material.dart';

class TestInfoChip extends StatelessWidget {
  const TestInfoChip({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xfff0f7f5),
        borderRadius: BorderRadius.circular(500),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff007353),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(width: 4),
          Icon(icon, color: const Color(0xff007353), size: 12),
        ],
      ),
    );
  }
}

class TestInfoLine extends StatelessWidget {
  const TestInfoLine({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color(0xff47524f),
            fontSize: 12,
            height: 1.5,
          ),
        ),
        const SizedBox(width: 2),
        Icon(icon, color: const Color(0xff47524f), size: 12),
      ],
    );
  }
}
