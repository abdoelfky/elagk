import 'package:elagk_pharmacy/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/email_activation_entity.dart';

class EmailUserActivationModel extends EmailUserActivation {
  const EmailUserActivationModel({required super.message});

  factory EmailUserActivationModel.fromJson(Map<String, dynamic> json) =>
      EmailUserActivationModel(
        message: json['message'],
      );
}
