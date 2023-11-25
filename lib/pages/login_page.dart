// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_firebase/pages/register_page.dart';

import 'package:chat_app_firebase/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_firebase/components/my_button.dart';
import 'package:chat_app_firebase/components/my_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  void signIn() async {
    final authService = Provider.of<ChatService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text.toString(),
          passwordController.text.toString(),
          context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Sign In",
                  onTap: signIn,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ));
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
