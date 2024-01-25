part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final LoginResponse loginResponse;

  const RegisterSuccess({required this.loginResponse});
}

class RegisterFailure extends RegisterState {
  final String message;

  const RegisterFailure({required this.message});

  @override
  List<Object> get props => [message];
}
