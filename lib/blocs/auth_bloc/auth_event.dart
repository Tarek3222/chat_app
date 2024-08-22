part of 'auth_bloc.dart';


sealed class AuthEvent {}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  LogInEvent({required this.email,required this.password});
}
class RegisterEvent extends AuthEvent {
   final String email;
  final String password;

  RegisterEvent({required this.email,required this.password});
}