import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSendOtpEvent extends AuthEvent {
  final String phoneNumber;
  const AuthSendOtpEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class AuthVerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;
  final String name;
  final String phoneNumber;
  final String address;

  const AuthVerifyOtpEvent({
    required this.verificationId,
    required this.smsCode,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  @override
  List<Object> get props => [
    verificationId,
    smsCode,
    name,
    phoneNumber,
    address,
  ];
}
