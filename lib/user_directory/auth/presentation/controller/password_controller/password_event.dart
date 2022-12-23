part of 'password_bloc.dart';

abstract class PasswordUserEvent extends Equatable {
  const PasswordUserEvent();

  @override
  List<Object> get props => [];
}

class UserForgetPasswordEvent extends PasswordUserEvent {
  final BuildContext context;
  final String email;

  const UserForgetPasswordEvent({required this.context, required this.email});

  @override
  List<Object> get props => [context, email];
}

class SendUserMailEvent extends PasswordUserEvent {
  final BuildContext context;
  final String email;

  const SendUserMailEvent({required this.context, required this.email});

  @override
  List<Object> get props => [context, email];
}

class ActivationUserEmailEvent extends PasswordUserEvent {
  final BuildContext context;
  final int code;

  const ActivationUserEmailEvent({required this.context, required this.code});

  @override
  List<Object> get props => [context, code];
}

class ResetUserPasswordEvent extends PasswordUserEvent {
  final BuildContext context;
  final String password;
  final String email;

  const ResetUserPasswordEvent({
    required this.context,
    required this.password,
    required this.email,
  });

  @override
  List<Object> get props => [context, password, email];
}
