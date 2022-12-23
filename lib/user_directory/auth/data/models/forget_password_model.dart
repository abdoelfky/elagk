import 'package:elagk_pharmacy/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/forget_password_entity.dart';

class ForgetUserPasswordModel extends ForgetUserPassword {
  const ForgetUserPasswordModel({required super.email});

  factory ForgetUserPasswordModel.fromJson(String jsonData) =>
      ForgetUserPasswordModel(email: jsonData);
}
