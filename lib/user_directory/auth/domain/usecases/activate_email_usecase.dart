import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/auth/domain/repository/base_auth_repository.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/core/usecase/base_usecase.dart';
import 'package:elagk_pharmacy/core/usecase/user_base_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/email_activation_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/repository/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class ActivateUserEmailUseCase
    extends UserBaseUseCase<EmailUserActivation, ActivationUserParameters> {
  final UserBaseAuthRepository baseAuthRepository;

  ActivateUserEmailUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, EmailUserActivation>> call(
      ActivationUserParameters parameters) async {
    return await baseAuthRepository.activateEmail(parameters);
  }
}

class ActivationUserParameters extends Equatable {
  final int code;

  const ActivationUserParameters({required this.code});

  @override
  List<Object> get props => [code];
}
