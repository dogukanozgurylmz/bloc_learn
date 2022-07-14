part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginValidateState extends LoginState {
  final bool isValidate;

  const LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  const LoginLoadingState(this.isLoading);
}

class LoginCompleteState extends LoginState {
  final LoginResponseModel model;

  const LoginCompleteState(this.model);
}
