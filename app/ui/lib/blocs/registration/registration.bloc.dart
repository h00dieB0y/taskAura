import 'package:bloc/bloc.dart';
import 'package:ui/validators/email_validator.dart';
import 'package:ui/validators/password_validator.dart';

import 'registration.event.dart';
import 'registration.state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationButtonPressed>(_onRegistrationButtonPressed);
  }

  void _onRegistrationButtonPressed(
    RegistrationButtonPressed event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    // Use the separate validator package
    final emailError = EmailValidator.validate(event.email);
    if (emailError != null) {
      emit(RegistrationFailure(emailError));
      return;
    }

    final passwordError = PasswordValidator.validate(event.password);
    if (passwordError != null) {
      emit(RegistrationFailure(passwordError));
      return;
    }

    final confirmPasswordError = PasswordValidator.validateConfirmPassword(
      event.password,
      event.confirmPassword,
    );

    if (confirmPasswordError != null) {
      emit(RegistrationFailure(confirmPasswordError));
      return;
    }

    // Simulate async operation (e.g., API call)
    await Future.delayed(const Duration(seconds: 1));

    // If all validation passes
    emit(RegistrationSuccess());
  }
}
