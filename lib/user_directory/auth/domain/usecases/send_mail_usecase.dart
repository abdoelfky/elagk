import 'package:dartz/dartz.dart';
import 'package:elagk_pharmacy/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/auth/domain/repository/base_auth_repository.dart';
import 'package:elagk_pharmacy/core/error/failure.dart';
import 'package:elagk_pharmacy/core/usecase/base_usecase.dart';
import 'package:elagk_pharmacy/core/usecase/user_base_usecase.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/entities/send_mail_entity.dart';
import 'package:elagk_pharmacy/user_directory/auth/domain/repository/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class SendUserMailUseCase extends UserBaseUseCase<SendUserMail, SendUserMailParameters> {
  final UserBaseAuthRepository baseAuthRepository;

  SendUserMailUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, SendUserMail>> call(SendUserMailParameters parameters) async {
    return await baseAuthRepository.sendMail(parameters);
  }
}

class SendUserMailParameters extends Equatable {
  final String email;
  // final String path;

  const SendUserMailParameters({required this.email});

  Map<String, dynamic> toJson() {
    return {
      "email": email
      // "path": path,
    };
  }

  @override
  List<Object> get props => [email];
}
