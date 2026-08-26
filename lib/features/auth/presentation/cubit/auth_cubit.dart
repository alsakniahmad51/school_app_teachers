import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final UserEntity user = await loginUseCase(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }
}
