import 'package:elagk_pharmacy/auth/domain/entities/login_pharmacy_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/user_login_entity.dart';

class LoginUserModel extends LoginUser{
    LoginUserModel({
    required super.userId,
    super.message,
    required super.isAuthenticated,
    required super.username,
    required super.email,
    required super.roles,
    required super.token,
    required super.expiresOn,
    });

    factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        userId: json["userId"],
        message: json["message"],
        isAuthenticated: json["isAuthenticated"],
        username: json["username"],
        email: json["email"],
        roles: json["roles"],
        token: json["token"],
        expiresOn: json["expiresOn"],
    );
}

