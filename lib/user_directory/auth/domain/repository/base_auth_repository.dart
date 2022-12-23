import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/login_pharmacy_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/activate_email_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/forget_password_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/login_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elagk_pharmacy/auth/domain/usecases/send_mail_usecase.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/user_login_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/activate_email_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/forget_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/login_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/send_mail_usecase.dart';

abstract class UserBaseAuthRepository {
  // Login pharmacy screen
  Future<Either<Failure, LoginUser>> login(LoginUserParameters parameters);

  // Forget password screen
  Future<Either<Failure, ForgetUserPassword>> forgetPassword(
      ForgetUserPasswordParameters parameters);

  Future<Either<Failure, SendUserMail>> sendMail(SendUserMailParameters parameters);

  // Activate email screen
  Future<Either<Failure, EmailUserActivation>> activateEmail(
      ActivationUserParameters parameters);

  // Reset password screen
  Future<Either<Failure, ResetUserPassword>> resetPassword(
      ResetUserPasswordParameters parameters);
}
