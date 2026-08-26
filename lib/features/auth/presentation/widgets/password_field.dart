import 'package:flutter/material.dart';
import 'package:teachers_app/core/widgets/text_field/custom_text_field.dart';
import 'package:teachers_app/core/widgets/text_field/field_validators.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      fieldType: FieldType.password,
      controller: _passwordController,
      radius: 16,

      keyboardType: TextInputType.visiblePassword,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      primaryColor: const Color(0xFF0E4F3F),
      secondaryBorderColor: const Color(0xFF0E4F3F),
      disabledBorderColor: const Color(0xFFABC4BE),
      negativeColor: const Color(0xFFDC2626),
      iconColor: const Color(0xFF0E4F3F),
    );
  }
}
