import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';
import 'package:grab_it/features/auth/domain/usecases/check_user_exists_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_event.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUsecase sendOtpUsecase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final CheckUserExistsUseCase checkUserExistsUseCase;

  AuthBloc({
    required this.sendOtpUsecase,
    required this.verifyOTPUseCase,
    required this.checkUserExistsUseCase,
  }) : super(AuthInitial()) {
    on<AuthSendOtpEvent>(_sendOtp);
    on<AuthVerifyOtpEvent>(_verifyOtp);
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
          (userExists) => emit(AuthOtpSent(verificationId: verificationId, userExists: userExists)),
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

    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) {
        if (event.userExists) {
          emit(AuthUserExistsState(user: user));
        } else {
          emit(AuthUserNewState(uid: user.id));
        }
      },
    );
  }
}
