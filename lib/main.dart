import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/views/sign_in_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
       debugShowCheckedModeBanner: false,
       routes: {
        SignInView.id:(context) => const SignInView(),
        RegisterView.id:(context) => const RegisterView(),
        ChatView.id:(context) => const ChatView(),
       },
       initialRoute: SignInView.id,
    );
  }
}
