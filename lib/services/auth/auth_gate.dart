// import 'package:chat_app_firebase/pages/home_page.dart';
// import 'package:chat_app_firebase/services/auth/login_or_register.dart';
// import 'package:chat_app_firebase/services/chat/chat_services.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

// class AuthGate extends StatelessWidget {
//   const AuthGate({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: ChatService.firebaseAuth.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return Text('Error is ${snapshot.error.toString()}');
//           }
//           if (snapshot.hasData) {
//             return const HomePage();
//           } else {
//             return const LoginOrRegister();
//           }
//         },
//       ),
//     );
//   }
// }
