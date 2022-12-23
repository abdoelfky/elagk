part of 'user_login_bloc.dart';

class LoginUserState extends Equatable {
  final LoginUser? loginUser;
  final RequestState loginRequestState;
  final ButtonState loginButtonState;
  final String loginMessage;

  const LoginUserState({
    this.loginUser,
    this.loginRequestState = RequestState.loading,
    this.loginButtonState = ButtonState.static,
    this.loginMessage = AppConstants.empty,
  });

  LoginUserState copyWith({
    LoginUser? loginUser,
    RequestState? loginRequestState,
    ButtonState? loginButtonState,
    String? loginMessage,
  }) {
    return LoginUserState(
      loginUser: loginUser ?? this.loginUser,
      loginRequestState: loginRequestState ?? this.loginRequestState,
      loginButtonState: loginButtonState ?? this.loginButtonState,
      loginMessage: loginMessage ?? this.loginMessage,
    );
  }

  @override
  List<Object?> get props => [
        loginUser,
        loginRequestState,
        loginButtonState,
        loginMessage,
      ];
}
