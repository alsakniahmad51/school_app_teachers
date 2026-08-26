import 'package:flutter/material.dart';

class ClassHeader extends StatelessWidget {
  const ClassHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الصف , الشعبة",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000F0B),
                height: 1.3,
              ),
            ),
          ),
          SizedBox(width: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Color(0xFF000F0B),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
