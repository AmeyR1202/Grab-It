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
  final bool userExists;
  final String address;

  const AuthVerifyOtpEvent({
    required this.verificationId,
    required this.smsCode,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.userExists,
  });

  @override
  List<Object> get props => [
    verificationId,
    smsCode,
    name,
    phoneNumber,
    address,
    userExists,
  ];
}

class AuthSaveProfileEvent extends AuthEvent {
  final String uid;
  final String name;
  final String phoneNumber;
  final String address;

  const AuthSaveProfileEvent({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  @override
  List<Object> get props => [uid, name, phoneNumber, address];
}
