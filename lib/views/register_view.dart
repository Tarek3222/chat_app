import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
 const RegisterView({super.key});

  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey=GlobalKey();

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
                Image.asset('assets/images/scholar.png',
                height: 100,
                ),
                const Center(
                  child:  Text(
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
                    'Register',
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Email can\'t be empty';
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
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Password can\'t be empty';
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
                        await registerUser();
                        showSnackBar(context, 'Registered successfully');
                        Navigator.pushNamed(context, ChatView.id, arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context,'weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,'email already in use');
                        }else if (e.code == 'invalid-email') {
                          showSnackBar(context,'invalid email');
                        }
                      }catch(e){
                        showSnackBar(context, 'Something went wrong');
                      }

                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  text: 'Register',
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> registerUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: email!, password: password!);
  }
}
