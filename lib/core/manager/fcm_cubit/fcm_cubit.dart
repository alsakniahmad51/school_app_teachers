import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachers_app/core/manager/fcm_cubit/fcm_state.dart';
import 'package:teachers_app/features/auth/presentation/cubit/auth_cubit.dart';

class FcmCubit extends Cubit<FcmState> {
  FcmCubit() : super(const FcmState());

  static const _fcmKey = 'fcm_token';

  Future<void> init(bool isRegister, AuthCubit? userProfileCubit) async {
    try {
      // await Firebase.initializeApp();
      final prefs = await SharedPreferences.getInstance();
      await FirebaseMessaging.instance.requestPermission();

      final cachedToken = prefs.getString(_fcmKey);
      if (cachedToken != null && cachedToken.isNotEmpty) {
        emit(state.copyWith(fcmToken: cachedToken));
        if (isRegister == false) {
          // sendTokenToServer(cachedToken, userProfileCubit?.userId ?? "");
        }
      } else {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          await prefs.setString(_fcmKey, token);
          emit(state.copyWith(fcmToken: token));
          // await sendTokenToServer(token, userProfileCubit?.userId ?? "");
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> deleteFcmToken(AuthCubit? userProfileCubit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await FirebaseMessaging.instance.deleteToken();

      await prefs.remove(_fcmKey);

      emit(state.copyWith(fcmToken: null));
      // sendTokenToServer('', userProfileCubit?.userId ?? "");
    } catch (e) {
      // تجاهل الخطأ أو عالجه لاحقاً
    }
  }
}
