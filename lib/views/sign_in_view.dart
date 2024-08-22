import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatView.id,
                              arguments: email);
          BlocProvider.of<ChatCubit>(context).getMessages();
        } else if (state is LoginFireBaseError) {
          showSnackBar(context, state.error);
        }else if(state is LoginError){
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
        inAsyncCall: state is LoginLoading,
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
                    onPressed: ()  {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(LogInEvent(email: email!, password: password!));
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
    );
  }
}
