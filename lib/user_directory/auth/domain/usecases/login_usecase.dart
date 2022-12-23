import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/core/usecase/base_usecase.dart';
import 'package:elagk_pharmacy/core/usecase/user_base_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/user_login_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/repository/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class UserLoginUseCase extends UserBaseUseCase<LoginUser, LoginUserParameters> {
  final UserBaseAuthRepository baseAuthRepository;

  UserLoginUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, LoginUser>> call(LoginUserParameters parameters) async {
    return await baseAuthRepository.login(parameters);
  }
}

class LoginUserParameters extends Equatable {
  final String email;
  final String password;

  const LoginUserParameters({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password
    };
  }

  @override
  List<Object> get props => [email, password];
}
