import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LogInEvent) {
        emit(LoginLoading());
        try {
          // ignore: unused_local_variable
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          emit(LoginFireBaseError(error: e.code));
        } catch (e) {
          emit(LoginError(error: e.toString()));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          FirebaseAuth auth = FirebaseAuth.instance;
          // ignore: unused_local_variable
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          emit(RegisterFireBaseError(error: e.code));
        } catch (e) {
          emit(RegisterError(error: e.toString()));
        }
      }
    });
  }
}
