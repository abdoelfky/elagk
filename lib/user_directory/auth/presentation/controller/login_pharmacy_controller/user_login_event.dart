part of 'user_login_bloc.dart';

abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends UserLoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  const LoginUserEvent({required this.context, required this.email, required this.password});

  @override
  List<Object> get props => [context, email, password];
}
