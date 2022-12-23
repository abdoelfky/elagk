import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/auth/domain/repository/base_auth_repository.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/core/usecase/base_usecase.dart';
import 'package:elagk_pharmacy/core/usecase/user_base_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/reset_password_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/repository/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class ResetUserPasswordUseCase
    extends UserBaseUseCase<ResetUserPassword, ResetUserPasswordParameters> {
  final UserBaseAuthRepository baseAuthRepository;

  ResetUserPasswordUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, ResetUserPassword>> call(
      ResetUserPasswordParameters parameters) async {
    return await baseAuthRepository.resetPassword(parameters);
  }
}

class ResetUserPasswordParameters extends Equatable {
  final String password;
  final String email;

  const ResetUserPasswordParameters({
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "email": email,
    };
  }

  @override
  List<Object> get props => [password, email];
}
