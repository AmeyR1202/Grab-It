import 'package:equatable/equatable.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final String verificationId;
  final bool userExists;
  const AuthOtpSent({required this.verificationId, required this.userExists});

  @override
  List<Object> get props => [verificationId, userExists];
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthFailureState extends AuthState {
  final String message;
  const AuthFailureState({required this.message});

  @override
  List<Object> get props => [message];
}

//  state for a completely new user
class AuthUserNewState extends AuthState {
  final String uid; // fb auth id
  final String mobileNumber;
  const AuthUserNewState({required this.uid, required this.mobileNumber});
  
  @override
  List<Object> get props => [uid, mobileNumber];
}

//  state for an existing, fully verified user
class AuthUserExistsState extends AuthState {
  final UserEntity user;
  const AuthUserExistsState({required this.user});
}
