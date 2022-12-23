import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/auth/domain/repository/base_auth_repository.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/core/usecase/base_usecase.dart';
import 'package:elagk_pharmacy/core/usecase/user_base_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/forget_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/repository/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class ForgetUserPasswordUseCase
    extends UserBaseUseCase<ForgetUserPassword, ForgetUserPasswordParameters> {
  final UserBaseAuthRepository baseAuthRepository;

  ForgetUserPasswordUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, ForgetUserPassword>> call(
      ForgetUserPasswordParameters parameters) async {
    return await baseAuthRepository.forgetPassword(parameters);
  }
}

class ForgetUserPasswordParameters extends Equatable {
  final String email;

  const ForgetUserPasswordParameters({required this.email});

  @override
  List<Object> get props => [email];
}
