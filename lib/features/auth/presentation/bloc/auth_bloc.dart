import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grab_it/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:grab_it/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_event.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUsecase sendOtpUsecase;
  final VerifyOTPUseCase verifyOTPUseCase;

  AuthBloc({required this.sendOtpUsecase, required this.verifyOTPUseCase})
    : super(AuthInitial()) {
    on<AuthSendOtpEvent>(_sendOtp);
    on<AuthVerifyOtpEvent>(_verifyOtp);
  }

  Future<void> _sendOtp(AuthSendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await sendOtpUsecase(event.phoneNumber);

    result.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (verificationId) => emit(AuthOtpSent(verificationId: verificationId)),
    );
  }

  Future<void> _verifyOtp(
    AuthVerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
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
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
