// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_firebase/model/register.dart';
import 'package:chat_app_firebase/pages/login_page.dart';

import 'package:chat_app_firebase/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_firebase/components/my_button.dart';
import 'package:chat_app_firebase/components/my_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var uNameController = TextEditingController();
  var uEmailController = TextEditingController();
  var uPhoneController = TextEditingController();
  var uPasswordController = TextEditingController();
  var uConfirmPasswordController = TextEditingController();
  void signUp() async {
    if (uPasswordController.text.toString() !=
        uConfirmPasswordController.text.toString()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password not match')));
      return;
    }
    final authService = context.read<ChatService>();
    try {
      await authService.signUpWithEmailandPassword(
        user: RegisterModel(
          uPassword: uPasswordController.text.toString(),
          uName: uNameController.text.toString(),
          uEmail: uEmailController.text.toString(),
          uPhone: uPhoneController.text.toString(),
        ),
      );
      uNameController.text = "";
      uEmailController.text = "";
      uPhoneController.text = "";
      uPasswordController.text = "";
      uConfirmPasswordController.text = "";
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
                  "Let's create an account for you!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                    controller: uNameController,
                    hintText: 'Name',
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: uEmailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: uPhoneController,
                    hintText: 'Phone',
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: uPasswordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: uConfirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Sign Up",
                  onTap: signUp,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                      },
                      child: const Text(
                        'Login now',
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
