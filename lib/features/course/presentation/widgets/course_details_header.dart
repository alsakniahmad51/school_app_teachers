import 'package:flutter/material.dart';

class CourseDetailsHeader extends StatelessWidget {
  const CourseDetailsHeader({super.key, required this.courseTitle});
final String courseTitle ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
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
          Align(
            alignment: Alignment.centerRight,
            child:  Text(
             courseTitle,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000F0B),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
