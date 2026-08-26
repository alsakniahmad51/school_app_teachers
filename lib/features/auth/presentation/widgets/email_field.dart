import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:teachers_app/core/widgets/text_field/custom_text_field.dart';
import 'package:teachers_app/core/widgets/text_field/field_validators.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required TextEditingController emailController})
    : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      fieldType: FieldType.email,
      controller: _emailController,
      radius: 16,

      prefix: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Icon(
          PhosphorIcons.user(),
          color: const Color(0xFF0E4F3F),
          size: 20,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      primaryColor: const Color(0xFF0E4F3F),
      secondaryBorderColor: const Color(0xFF0E4F3F),
      disabledBorderColor: const Color(0xFFABC4BE),
      negativeColor: const Color(0xFFDC2626),
      iconColor: const Color(0xFF0E4F3F),
    );
  }
}
