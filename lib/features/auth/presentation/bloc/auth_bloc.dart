import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';
import 'package:grab_it/features/auth/domain/usecases/check_user_exists_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/save_user_profile_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_event.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUsecase sendOtpUsecase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final CheckUserExistsUseCase checkUserExistsUseCase;
  final SaveUserProfileUsecase saveUserProfileUsecase;

  AuthBloc({
    required this.sendOtpUsecase,
    required this.verifyOTPUseCase,
    required this.checkUserExistsUseCase,
    required this.saveUserProfileUsecase,
  }) : super(AuthInitial()) {
    on<AuthSendOtpEvent>(_sendOtp);
    on<AuthVerifyOtpEvent>(_verifyOtp);
    on<AuthSaveProfileEvent>(_saveProfile);
  }

  Future<void> _sendOtp(AuthSendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Run both network calls concurrently to save time
    final results = await Future.wait([
      sendOtpUsecase(event.phoneNumber),
      checkUserExistsUseCase(event.phoneNumber),
    ]);

    final otpResult = results[0] as Either<Failures, String>;
    final existsResult = results[1] as Either<Failures, bool>;

    otpResult.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (verificationId) {
        existsResult.fold(
          (failure) => emit(AuthFailureState(message: failure.message)),
          (userExists) => emit(
            AuthOtpSent(verificationId: verificationId, userExists: userExists),
          ),
        );
      },
    );
  }

  Future<void> _verifyOtp(
    AuthVerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await verifyOTPUseCase(
      VerifyOTPParams(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
        name: event.name,
        phoneNumber: event.phoneNumber,
        address: event.address,
      ),
    );

    result.fold((failure) => emit(AuthFailureState(message: failure.message)), (
      user,
    ) {
      if (event.userExists) {
        emit(AuthUserExistsState(user: user));
      } else {
        emit(AuthUserNewState(uid: user.id, mobileNumber: user.mobileNumber));
      }
    });
  }

  Future<void> _saveProfile(
    AuthSaveProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final userEntity = UserEntity(
      id: event.uid,
      name: event.name,
      mobileNumber: event.phoneNumber,
      address: event.address,
      role: 'user',
    );

    final result = await saveUserProfileUsecase(userEntity);

    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => emit(AuthUserExistsState(user: user)),
    );
  }
}
