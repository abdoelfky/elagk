import 'dart:async';

import 'package:elagk_pharmacy/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/core/global/app_colors.dart';
import 'package:elagk_pharmacy/core/utils/app__fonts.dart';
import 'package:elagk_pharmacy/core/utils/app_constants.dart';
import 'package:elagk_pharmacy/core/utils/app_routes.dart';
import 'package:elagk_pharmacy/core/utils/argument_models.dart';
import 'package:elagk_pharmacy/core/utils/enums.dart';
import 'package:elagk_pharmacy/core/utils/navigation.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/activate_email_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/forget_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/send_mail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordUserBloc extends Bloc<PasswordUserEvent, PasswordUserState> {
  final ForgetUserPasswordUseCase forgetPasswordUseCase;
  final SendUserMailUseCase sendMailUseCase;
  final ActivateUserEmailUseCase activateEmailUseCase;
  final ResetUserPasswordUseCase resetPasswordUseCase;

  PasswordUserBloc(
    this.forgetPasswordUseCase,
    this.sendMailUseCase,
    this.activateEmailUseCase,
    this.resetPasswordUseCase,
  ) : super(const PasswordUserState()) {
    on<UserForgetPasswordEvent>(_forgetPassword);
    on<SendUserMailEvent>(_sendMail);
    on<ActivationUserEmailEvent>(_activateEmail);
    on<ResetUserPasswordEvent>(_resetPassword);
  }

  // Forget password screen
  FutureOr<void> _forgetPassword(
      UserForgetPasswordEvent event, Emitter<PasswordUserState> emit) async {
    emit(state.copyWith(forgetPasswordButtonState: ButtonState.loading));
    final result = await forgetPasswordUseCase(
      ForgetUserPasswordParameters(email: event.email),
    );
    result.fold((l) {
      emit(
        state.copyWith(
          forgetPasswordRequestState: RequestState.error,
          forgetPasswordButtonState: ButtonState.static,
          forgetPasswordMessage: l.message,
        ),
      );
    }, (r) {
      emit(
        state.copyWith(
          forgetPasswordRequestState: RequestState.loaded,
          forgetPasswordButtonState: ButtonState.static,
          forgetPassword: r,
        ),
      );
      if (state.forgetPassword!.email == event.email) {
        navigateTo(
          context: event.context,
          screenRoute: Routes.OTPUserVerifyScreen,
          arguments: OTPArguments(
            email: event.email,
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Email ${state.forgetPassword!.email}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: AppColors.red,
          textColor: Colors.white,
          fontSize: FontSize.s16,
        );
      }
    });
  }

  // Send mail
  FutureOr<void> _sendMail(
      SendUserMailEvent event, Emitter<PasswordUserState> emit) async {
    final result = await sendMailUseCase(
      SendUserMailParameters(email: event.email),
    );
    result.fold((l) {
      emit(
        state.copyWith(
          sendMailRequestState: RequestState.error,
          sendMailMessage: l.message,
        ),
      );
    }, (r) {
      emit(
        state.copyWith(
          sendMailRequestState: RequestState.loaded,
          sendMail: r,
        ),
      );
    });
  }

  // Activate email screen
  int? pinCode;

  submitPinCode(int pin) {
    pinCode = pin;
  }

  FutureOr<void> _activateEmail(
      ActivationUserEmailEvent event, Emitter<PasswordUserState> emit) async {
    emit(state.copyWith(emailActivationButtonState: ButtonState.loading));
    final result = await activateEmailUseCase(
      ActivationUserParameters(code: event.code),
    );
    result.fold(
      (l) {
        emit(
          state.copyWith(
            emailActivationRequestState: RequestState.error,
            emailActivationButtonState: ButtonState.static,
            emailActivationMessage: l.message,
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
            emailActivationRequestState: RequestState.loaded,
            emailActivationButtonState: ButtonState.static,
            emailActivation: r,
          ),
        );
        navigateFinalTo(
          context: event.context,
          screenRoute: Routes.resetUserPasswordScreen,
        );
      },
    );
  }

  // Reset password screen
  FutureOr<void> _resetPassword(
      ResetUserPasswordEvent event, Emitter<PasswordUserState> emit) async {
    emit(state.copyWith(resetPasswordButtonState: ButtonState.loading));
    final result = await resetPasswordUseCase(
      ResetUserPasswordParameters(
        password: event.password,
        email: event.email,
      ),
    );
    result.fold((l) {
      emit(
        state.copyWith(
          resetPasswordRequestState: RequestState.error,
          resetPasswordButtonState: ButtonState.static,
          resetPasswordMessage: l.message,
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
    }, (r) {
      emit(
        state.copyWith(
          resetPasswordRequestState: RequestState.loaded,
          resetPasswordButtonState: ButtonState.static,
          resetPassword: r,
        ),
      );
        navigateFinalTo(
          context: event.context,
          screenRoute: Routes.loginPharmacyScreen,
        );
    });
  }
}
