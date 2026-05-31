import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  // Sends an OTP to the phone number and returns the 'verificationId'
  Future<Either<Failures, String>> sendOTP(String phoneNumber);

  // verify the otp and create/fetch the user from the database
  Future<Either<Failures, UserEntity>> verifyOTPAndLogin({
    required String verificationId,
    required String smsCode,
    required String name,
    required String phoneNumber,
    required String address,
  });

  Future<Either<Failures, bool>> checkUserExists(String phoneNumber);
}
