import 'package:equatable/equatable.dart';

class EmailUserActivation extends Equatable {
  final String message;
  // May be = "Activation Failed" or "Activation Success".

  const EmailUserActivation({required this.message});

  @override
  List<Object> get props => [message];
}
