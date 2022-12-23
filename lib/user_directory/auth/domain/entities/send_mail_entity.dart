import 'package:equatable/equatable.dart';

class SendUserMail extends Equatable {
  final String message;

  const SendUserMail({required this.message});

  @override
  List<Object> get props => [message];
}
