import 'package:flutter/material.dart';

import '../widgets/attachment_file_item.dart';

class CourseAttachmentsPage extends StatelessWidget {
  const CourseAttachmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: const Color(0xFF007353),
        ),
      ),
      body: const Column(
        children: [
          AttachmentFileItem(
            title: 'Session 1.0.pdf',
            extension: 'PDF',
            isPrimary: true,
          ),
          SizedBox(height: 12),
          AttachmentFileItem(title: 'Session 1.1.pdf', extension: 'PDF'),
        ],
      ),
    );
  }
}
