
import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/core/error/exceptions.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/user_directory/auth/data/datasource/base_auth_remote_datasource.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/user_login_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/repository/base_auth_repository.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/activate_email_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/forget_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/login_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/usecases/send_mail_usecase.dart';

class UserAuthRepository extends UserBaseAuthRepository {
  final UserBaseAuthRemoteDataSource baseAuthRemoteDataSource;

  UserAuthRepository(this.baseAuthRemoteDataSource);

  // Login pharmacy screen
  @override
  Future<Either<Failure, LoginUser>> login(
      LoginUserParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.login(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  // Forget password screen
  @override
  Future<Either<Failure, ForgetUserPassword>> forgetPassword(
      ForgetUserPasswordParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.forgetPassword(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, SendUserMail>> sendMail(
      SendUserMailParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.sendMail(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  // Activate email screen
  @override
  Future<Either<Failure, EmailUserActivation>> activateEmail(
      ActivationUserParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.activateEmail(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  // Reset password screen
  @override
  Future<Either<Failure, ResetUserPassword>> resetPassword(
      ResetUserPasswordParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.resetPassword(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
