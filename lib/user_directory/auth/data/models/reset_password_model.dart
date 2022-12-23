import 'package:elagk_pharmacy/user_directory/auth/domain/entities/reset_password_entity.dart';

class ResetUserPasswordModel extends ResetUserPassword {
  const ResetUserPasswordModel({required super.message});

  factory ResetUserPasswordModel.fromJson(String jsonData) => ResetUserPasswordModel(
    message: jsonData,
  );
}
