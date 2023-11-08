import 'package:chat_app_firebase/pages/chat_page.dart';
import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.signOut();
  }

  bool snackBarCalled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.home_outlined),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: snackBarCalled ? Colors.transparent : Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    snackBarCalled
                        ? Icon(
                            Icons.abc,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                    Text(
                      'New Chat',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Icon(
              Icons.account_circle_outlined,
            )
          ],
        ),
      ),
    );
  }
}


//  ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     clipBehavior: Clip.none,

//                     width: MediaQuery.of(context).size.width,
//                     onVisible: () {
//                       snackBarCalled = true;
//                       setState(() {});
//                     },

//                     // margin: EdgeInsets.all(25),
//                     backgroundColor: Colors.grey.shade100.withOpacity(0.1),
//                     elevation: 0,
//                     behavior: SnackBarBehavior.floating,
//                     // margin: EdgeInsets.all(5),

//                     shape: BeveledRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     action: SnackBarAction(
//                       label: 'ok',
//                       onPressed: () {},
//                     ),
//                     content: AlertDialog(
//                       elevation: 0,
//                       content: ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         leading: Icon(Icons.chat),
//                         title: Text('New Chat'),
//                         subtitle: Text("Send a message to your contact"),
//                       ),
//                     ),
//                   ),
//                 );