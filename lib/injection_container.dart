import 'package:get_it/get_it.dart';
import 'package:grab_it/features/auth/data/repository/auth_repository_impl.dart';
import 'package:grab_it/features/auth/domain/repositories/auth_repository.dart';
import 'package:grab_it/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => AuthBloc(sendOtpUsecase: sl(), verifyOTPUseCase: sl()),
  );

  // usecases
  sl.registerLazySingleton(() => SendOtpUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));

  // repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // datasources
  // sl.registerLazySingleton<AuthRemoteDatasource>(
  //   () => AuthRemoteDatasourceImpl(firebaseAuth: sl(), firestore: sl()),
  // );
}
