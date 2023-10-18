import 'package:chat_app_firebase/pages/login_page.dart';
import 'package:chat_app_firebase/pages/register_page.dart';
import 'package:chat_app_firebase/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginOrRegister(),
    );
  }
}
