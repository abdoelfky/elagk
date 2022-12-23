import 'package:equatable/equatable.dart';

class ForgetUserPassword extends Equatable {
  final String email; // May be = "Not Found" instead of email.

  const ForgetUserPassword({required this.email});

  @override
  List<Object> get props => [email];
}
