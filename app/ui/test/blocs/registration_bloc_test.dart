import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/blocs/registration/registration.bloc.dart';
import 'package:ui/blocs/registration/registration.event.dart';
import 'package:ui/blocs/registration/registration.state.dart';

void main() {
  group('RegistrationBloc', () {
    // Initial state test
    test('initial state is RegistrationInitial', () {
      final bloc = RegistrationBloc();
      expect(bloc.state, RegistrationInitial());
    });

    // Test for successful registration
    blocTest<RegistrationBloc, RegistrationState>(
      'emits [RegistrationLoading, RegistrationSuccess] when RegistrationButtonPressed is added and passwords match',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(RegistrationButtonPressed(
        email: 'test@example.com',
        password: 'Password12\$',
        confirmPassword: 'Password12\$',
      )),
      wait: const Duration(seconds: 2), // Wait for the simulated delay
      expect: () => [
        RegistrationLoading(), // State after loading starts
        RegistrationSuccess(), // Success state when passwords match
      ],
    );

    // Test for failed registration due to invalid email
    blocTest<RegistrationBloc, RegistrationState>(
      'emits [RegistrationLoading, RegistrationFailure] when email is invalid',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(RegistrationButtonPressed(
        email: 'invalidEmail',
        password: 'Password12\$',
        confirmPassword: 'Password12\$',
      )),
      wait: const Duration(seconds: 2), // Wait for the simulated delay
      expect: () => [
        RegistrationLoading(), // State after loading starts
        const RegistrationFailure(
            'Please enter a valid email'), // Failure state when email is invalid
      ],
    );

    // Test for failed registration due to mismatched passwords
    blocTest<RegistrationBloc, RegistrationState>(
      'emits [RegistrationLoading, RegistrationFailure] when passwords do not match',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(RegistrationButtonPressed(
        email: 'test@example.com',
        password: 'Password12\$',
        confirmPassword: 'wrongPassword',
      )),
      wait: const Duration(seconds: 2), // Wait for the simulated delay
      expect: () => [
        RegistrationLoading(), // State after loading starts
        const RegistrationFailure(
            'Passwords do not match'), // Failure state when passwords don't match
      ],
    );
  });
}
