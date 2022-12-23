import 'dart:async';

import 'package:elagk_pharmacy/auth/domain/entities/login_pharmacy_entity.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/login_usecase.dart';
import 'package:elagk_pharmacy/core/global/app_colors.dart';
import 'package:elagk_pharmacy/core/utils/app__fonts.dart';
import 'package:elagk_pharmacy/core/utils/app_constants.dart';
import 'package:elagk_pharmacy/core/utils/app_routes.dart';
import 'package:elagk_pharmacy/core/utils/enums.dart';
import 'package:elagk_pharmacy/core/utils/navigation.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/user_login_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'user_login_event.dart';

part 'user_login_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final UserLoginUseCase loginUseCase;

  LoginUserBloc(this.loginUseCase) : super(const LoginUserState()) {
    on<LoginUserEvent>(_login);
  }

  FutureOr<void> _login(
      LoginUserEvent event, Emitter<LoginUserState> emit) async {
    emit(state.copyWith(loginButtonState: ButtonState.loading));
    final result = await loginUseCase(
      LoginUserParameters(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (l) {
        emit(
          state.copyWith(
            loginRequestState: RequestState.error,
            loginButtonState: ButtonState.static,
            loginMessage: l.message,
          ),
        );
        Fluttertoast.showToast(
          msg: l.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.red,
          textColor: Colors.white,
          fontSize: FontSize.s16,
        );
      },
      (r) {
        emit(
          state.copyWith(
            loginRequestState: RequestState.loaded,
            loginButtonState: ButtonState.static,
            loginUser: r,
          ),
        );
        navigateFinalTo(
          context: event.context,
          screenRoute: Routes.homeDrawerScreen,
        );
      },
    );
  }
}
