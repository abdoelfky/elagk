import 'package:dio/dio.dart';
import 'package:elagk_pharmacy/auth/data/models/email_activation_model.dart';
import 'package:elagk_pharmacy/auth/data/models/forget_password_model.dart';
import 'package:elagk_pharmacy/auth/data/models/login_pharmacy_model.dart';
import 'package:elagk_pharmacy/auth/data/models/reset_password_model.dart';
import 'package:elagk_pharmacy/auth/data/models/send_mail_model.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/activate_email_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/forget_password_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/login_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/send_mail_usecase.dart';
import 'package:elagk_pharmacy/core/error/exceptions.dart';
import 'package:elagk_pharmacy/core/local/cache_helper.dart';
import 'package:elagk_pharmacy/core/network/api_constants.dart';
import 'package:elagk_pharmacy/core/network/error_message_model.dart';
import 'package:elagk_pharmacy/core/utils/app_constants.dart';
import 'package:elagk_pharmacy/user_directory/auth/data/models/email_activation_model.dart';
import 'package:elagk_pharmacy/user_directory/auth/data/models/forget_password_model.dart';
import 'package:elagk_pharmacy/user_directory/auth/data/models/login_pharmacy_model.dart';
import 'package:elagk_pharmacy/user_directory/auth/data/models/reset_password_model.dart';
import 'package:elagk_pharmacy/user_directory/auth/data/models/send_mail_model.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/activate_email_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/forget_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/login_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/send_mail_usecase.dart';

abstract class UserBaseAuthRemoteDataSource {
  // Login pharmacy screen
  Future<LoginUserModel> login(LoginUserParameters parameters);

  // Forget password screen
  Future<ForgetUserPasswordModel> forgetPassword(
      ForgetUserPasswordParameters parameters);

  Future<SendUserMailModel> sendMail(SendUserMailParameters parameters);

  // Activate email screen
  Future<EmailUserActivationModel> activateEmail(ActivationUserParameters parameters);

  // Reset password screen
  Future<ResetUserPasswordModel> resetPassword(ResetUserPasswordParameters parameters);
}

class UserAuthRemoteDataSource extends UserBaseAuthRemoteDataSource {
  static const Map<String, String> headers = {
    'Content-Type': 'application/json'
  };

  Options options = Options(
    headers: headers,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  @override
  Future<LoginUserModel> login(LoginUserParameters parameters) async {
    final response = await Dio().post(
      ApiConstants.login,
      data: parameters.toJson(),
      options: options,
    );
    if (response.statusCode == 200) {
      CacheHelper.setData(key: AppConstants.userId, value: response.data[AppConstants.userId]);
      CacheHelper.setData(key: AppConstants.token, value: response.data[AppConstants.token]);
      return LoginUserModel.fromJson(response.data);
    } else {
      print(response.data);
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<ForgetUserPasswordModel> forgetPassword(
      ForgetUserPasswordParameters parameters) async {
    final response = await Dio().get(
      ApiConstants.forgetPasswordEmailPath(parameters.email),
    );
    // success state.
    if (response.statusCode == 200) {
      // "response.data" = "email" or "Not Found". // TODO: handle it "in backend"
      return ForgetUserPasswordModel.fromJson(response.data);
      // failed state.
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<SendUserMailModel> sendMail(SendUserMailParameters parameters) async {
    final response = await Dio().post(
      ApiConstants.sendMail,
      data: parameters.toJson(),
      options: options,
    );
    if (response.statusCode == 200) {
      return SendUserMailModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<EmailUserActivationModel> activateEmail(
      ActivationUserParameters parameters) async {
    final response = await Dio().get(
      ApiConstants.activationCodePath(parameters.code),
      options: options,
    );
    if (response.statusCode == 200) {
      return EmailUserActivationModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<ResetUserPasswordModel> resetPassword(
      ResetUserPasswordParameters parameters) async {
    final response = await Dio().post(
      ApiConstants.resetPassword,
      data: parameters.toJson(),
      options: options,
    );
    if (response.statusCode == 200) {
      return ResetUserPasswordModel.fromJson(response.data);
      // failed state.
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
