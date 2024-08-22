part of 'auth_bloc.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}
class LoginLoading extends AuthState{}
class LoginSuccess extends AuthState{}
class LoginFireBaseError extends AuthState{
  String error;
  LoginFireBaseError({required this.error});
}
class LoginError extends AuthState{
  String error;
  LoginError({required this.error});
}

class RegisterLoading extends AuthState{}
class RegisterSuccess extends AuthState{}
class RegisterFireBaseError extends AuthState{
  String error;
  RegisterFireBaseError({required this.error});
}
class RegisterError extends AuthState{
  String error;
  RegisterError({required this.error});
}