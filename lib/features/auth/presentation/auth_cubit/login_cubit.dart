import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/core/services/token_storage.dart';
import 'package:teachers_app/features/auth/domain/entities/auth_user.dart';
import 'package:teachers_app/features/auth/domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  final LoginUseCase loginUseCase;

  Future<void> login({
    required String userName,
    required String password,
    required String fcmToken,
  }) async {
    emit(LoginLoading());

    final result = await loginUseCase(userName, password, fcmToken);
    result.fold((failure) => emit(LoginFailure(failure.message)), (user) async {
      emit(LoginSuccess(user));
      await TokenStorage.saveToken(user.accessToken);
    });
  }
}
