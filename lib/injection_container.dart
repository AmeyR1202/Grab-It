import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:grab_it/features/auth/data/datasources/auth_remot_datasource_impl.dart';
import 'package:grab_it/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:grab_it/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';
import 'package:grab_it/features/auth/domain/usecases/check_user_exists_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/save_user_profile_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      sendOtpUsecase: sl(),
      verifyOTPUseCase: sl(),
      checkUserExistsUseCase: sl(),
      saveUserProfileUsecase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => SendOtpUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
  sl.registerLazySingleton(() => CheckUserExistsUseCase(sl()));
  sl.registerLazySingleton(() => SaveUserProfileUsecase(sl()));

  // repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  // Datasources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemotDatasourceImpl(firebaseAuth: sl(), firestore: sl()),
  );
}
