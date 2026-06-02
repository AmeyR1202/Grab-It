import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/core/usecases/usecase.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';

class SaveUserProfileUsecase implements Usecase<UserEntity, UserEntity> {
  final AuthRepository repository;

  SaveUserProfileUsecase(this.repository);

  @override
  Future<Either<Failures, UserEntity>> call(UserEntity params) async {
    return await repository.saveUserProfile(params);
  }
}
