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
  AuthOtpSent({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
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
