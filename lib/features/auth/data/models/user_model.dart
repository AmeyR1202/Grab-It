import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grab_it/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed()
abstract class UserModel with _$UserModel {
  // Added this private constructor so we can add custom methods like toEntity()
  const UserModel._();

  const factory UserModel({
    required String id,
    required String name,
    required String mobileNumber,
    required String address,
    @Default('user') String role, // setting default using freezed
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      mobileNumber: mobileNumber,
      address: address,
      role: role,
    );
  }
}
