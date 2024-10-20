import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegistrationButtonPressed({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}
