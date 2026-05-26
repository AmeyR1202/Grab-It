import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/exceptions.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failures, String>> sendOTP(String phoneNumber) async {
    try {
      final verificationId = await remoteDatasource.sendOTP(phoneNumber);
      return right(verificationId);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> verifyOTPAndLogin({
    required String verificationId,
    required String smsCode,
    required String name,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      final userModel = await remoteDatasource.verifyOTPAndLogin(
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
      );
      // We convert the Model to the Entity right here before it enters Domain!
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
