import 'package:flutter/material.dart';

import '../widgets/attachment_file_item.dart';

class CourseAttachmentsPage extends StatelessWidget {
  const CourseAttachmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AttachmentFileItem(
          title: 'Session 1.0.pdf',
          extension: 'PDF',
          isPrimary: true,
        ),
        SizedBox(height: 12),
        AttachmentFileItem(title: 'Session 1.1.pdf', extension: 'PDF'),
      ],
    );
  }
}
