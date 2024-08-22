
import 'package:chat_app/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
   Future<void> userLogIn({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      // ignore: unused_local_variable
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
} on FirebaseAuthException catch (e) {
  emit(LoginFireBaseError(error: e.code));
}catch (e) {
  emit(LoginError(error: e.toString()));
}
  }

    Future<void> userRegister({required String email, required String password}) async {
    emit(RegisterLoading());
    try {
   FirebaseAuth auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      emit(RegisterSuccess());
} on FirebaseAuthException catch (e) {
  emit(RegisterFireBaseError(error: e.code));
}catch (e) {
  emit(RegisterError(error: e.toString()));
}
  }
}
