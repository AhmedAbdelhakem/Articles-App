part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialStates extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

