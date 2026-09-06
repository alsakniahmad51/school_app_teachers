import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/auth/presentation/auth_cubit/login_cubit.dart';
import 'package:teachers_app/features/auth/presentation/widgets/email_field.dart';
import 'package:teachers_app/features/auth/presentation/widgets/password_field.dart';
import 'package:teachers_app/features/home/presentation/pages/home_page.dart';

import 'primary_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().login(
      userName: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('مرحباً ')));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          );
          // context.navigationWithFade(HomePage());
        }

        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  children: [
                    Text(
                      "البريد الإلكتروني / اسم المستخدم ",
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RequiredText(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              EmailField(emailController: _emailController),

              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  children: [
                    Text(
                      'كلمة المرور ',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RequiredText(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              PasswordField(passwordController: _passwordController),
              const SizedBox(height: 12),

              PrimaryButton(
                text: 'تسجيل الدخول',
                isLoading: isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        );
      },
    );
  }
}

class RequiredText extends StatelessWidget {
  const RequiredText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "(مطلوب)",
      style: TextStyle(
        color: Colors.red,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
