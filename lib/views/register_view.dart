import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/auth_cubit/auth_state.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
          if (state is RegisterSuccess) {
          Navigator.pop(context);
        } else if (state is RegisterFireBaseError) {
          showSnackBar(context, state.error);
        }else if(state is RegisterError){
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading,
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
                        validator: (value) {
                          if (value!.isEmpty) {
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
                        validator: (value) {
                          if (value!.isEmpty) {
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
                          BlocProvider.of<AuthCubit>(context)
                              .userRegister(email: email!, password: password!);
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
      },
    );
  }
}
