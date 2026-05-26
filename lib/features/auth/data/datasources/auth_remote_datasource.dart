import 'package:grab_it/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDatasource {
  // Talks to Firebase to send OTP
  Future<String> sendOTP(String phoneNumber);
  // to verify the otp
  Future<UserModel> verifyOTPAndLogin({
    required String verificationId,
    required String smsCode,
    required String name,
    required String phoneNumber,
    required String address,
  });
}
