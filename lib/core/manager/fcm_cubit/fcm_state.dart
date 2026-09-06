class FcmState {
  final String? fcmToken;
  final String? deviceId;

  const FcmState({
    this.fcmToken,
    this.deviceId,
  });

  FcmState copyWith({
    String? fcmToken,
    String? deviceId,
  }) {
    return FcmState(
      fcmToken: fcmToken ?? this.fcmToken,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
