import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/core/usecases/usecase.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';

class VerifyOTPUseCase implements Usecase<UserEntity, VerifyOTPParams> {
  final AuthRepository repository;
  VerifyOTPUseCase(this.repository);

  @override
  Future<Either<Failures, UserEntity>> call(VerifyOTPParams params) async {
    return await repository.verifyOTPAndLogin(
      verificationId: params.verificationId,
      smsCode: params.smsCode,
      name: params.name,
      phoneNumber: params.phoneNumber,
      address: params.address,
    );
  }
}

// creating custom params because usecase requires more than one arg
class VerifyOTPParams {
  final String verificationId;
  final String smsCode;
  final String name;
  final String phoneNumber;
  final String address;
  VerifyOTPParams({
    required this.verificationId,
    required this.smsCode,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });
}
