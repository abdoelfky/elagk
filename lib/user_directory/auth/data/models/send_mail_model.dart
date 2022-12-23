
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/send_mail_entity.dart';

class SendUserMailModel extends SendUserMail {
  const SendUserMailModel({required super.message});

  factory SendUserMailModel.fromJson(Map<String, dynamic> json) => SendUserMailModel(
        message: json['message'],
      );
}
