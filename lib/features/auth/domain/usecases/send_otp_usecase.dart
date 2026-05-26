import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/core/usecases/usecase.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';

// usecase<returnType, ParameterType)
class SendOtpUsecase implements Usecase<String, String> {
  final AuthRepository repository;

  SendOtpUsecase(this.repository);

  @override
  // The parameter is the phoneNumber
  Future<Either<Failures, String>> call(String phoneNumber) async {
    return await repository.sendOTP(phoneNumber);
  }
}
