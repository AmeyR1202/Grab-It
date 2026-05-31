import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/core/usecases/usecase.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';

class CheckUserExistsUseCase implements Usecase<bool, String> {
  final AuthRepository repository;

  CheckUserExistsUseCase(this.repository);

  @override
  Future<Either<Failures, bool>> call(String phoneNumber) async {
    return await repository.checkUserExists(phoneNumber);
  }
}
