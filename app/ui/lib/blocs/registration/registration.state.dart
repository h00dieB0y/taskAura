import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  R when<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function() onSuccess,
    required R Function(String message) onFailure,
  });
}

class RegistrationInitial extends RegistrationState {
  @override
  R when<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function() onSuccess,
    required R Function(String message) onFailure,
  }) {
    return onInitial();
  }

  @override
  List<Object?> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  R when<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function() onSuccess,
    required R Function(String message) onFailure,
  }) {
    return onLoading();
  }

  @override
  List<Object?> get props => [];
}

class RegistrationSuccess extends RegistrationState {
  @override
  R when<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function() onSuccess,
    required R Function(String message) onFailure,
  }) {
    return onSuccess();
  }

  @override
  List<Object?> get props => [];
}

class RegistrationFailure extends RegistrationState {
  final String message;

  const RegistrationFailure(this.message);

  @override
  R when<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function() onSuccess,
    required R Function(String message) onFailure,
  }) {
    return onFailure(message);
  }

  @override
  List<Object?> get props => [message];
}
