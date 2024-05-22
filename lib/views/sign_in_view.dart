import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatefulWidget {
 const SignInView({super.key});
 static const String id = 'SignInView';

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    onChanged: (data) {
                      email = data;
                    },
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                    hintText: 'Email'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    onChanged: (data) {
                      password = data;
                    },
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    obscureText: true,
                    hintText: 'Password'),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                       setState(() {
                         isLoading = true;
                       });
                        try {
                          await userLogIn();
                          showSnackBar(context, 'Log In Successful');
                          Navigator.pushNamed(context, ChatView.id, arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                                context, 'Wrong password provided for that user.');
                          }else if (e.code == 'invalid-email') {
                            showSnackBar(context, 'invalid email');
                          }
                        }catch(e){
                          showSnackBar(context, 'Something went wrong');
                        }
                        setState(() {
                        isLoading = false;
                      });
                      }
                  },
                  text: 'Sign In',
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterView.id);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userLogIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
