part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class RegisterSuccessState extends SignupState {}

class RegisterFailureState extends SignupState {
  final String errorMessage;

  RegisterFailureState(this.errorMessage);
}