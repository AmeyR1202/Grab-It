import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String mobileNumber;
  final String address;
  final String role; // 'user' or 'owner'

  const UserEntity({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.address,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, mobileNumber, address, role];
}
