import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/network/dio_consumer.dart';
import 'package:teachers_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:teachers_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:teachers_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:teachers_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../widgets/auth_header.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFB9B9B9),
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => AuthCubit(
                loginUseCase: LoginUseCase(
                  AuthRepositoryImpl(
                    remoteDataSource: AuthRemoteDataSourceImpl(
                      dioConsumer: DioConsumer(Dio()),
                    ),
                  ),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    color: const Color(0xFFF5F5F5),
                    child: Column(
                      children: [
                        SizedBox(height: 37),

                        AuthHeader(),
                        SizedBox(height: 18),
                        LoginForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  const _StatusIcon({
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _StatusIconPainter(color)),
    );
  }
}

class _StatusIconPainter extends CustomPainter {
  final Color color;

  const _StatusIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.7);
    path.lineTo(size.width * 0.55, size.height * 0.1);
    path.lineTo(size.width * 0.9, size.height * 0.7);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
