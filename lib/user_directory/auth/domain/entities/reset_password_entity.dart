import 'package:equatable/equatable.dart';

class ResetUserPassword extends Equatable {
  final String message;

  const ResetUserPassword({required this.message});

  @override
  List<Object> get props => [message];
}