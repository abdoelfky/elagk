import 'package:equatable/equatable.dart';

class LoginUser extends Equatable {
  final String userId;
  String? message;
  final bool isAuthenticated;
  final String username;
  final String email;
  final List<dynamic> roles;
  final String token;
  final String expiresOn;

  LoginUser({
    required this.userId,
    this.message,
    required this.isAuthenticated,
    required this.username,
    required this.email,
    required this.roles,
    required this.token,
    required this.expiresOn,
  });

  @override
  List<Object?> get props =>
      [
        userId,
        message,
        isAuthenticated,
        username,
        email,
        roles,
        token,
        expiresOn,
      ];
}
