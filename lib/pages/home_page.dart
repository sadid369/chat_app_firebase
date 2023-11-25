import 'package:chat_app_firebase/model/register.dart';
import 'package:chat_app_firebase/pages/chat_page.dart';
import 'package:chat_app_firebase/pages/login_page.dart';

import 'package:chat_app_firebase/services/chat/chat_services.dart';
import 'package:chat_app_firebase/widgets/msg_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> signOut() async {
    context.read<ChatService>().signOut();
  }

  List<Map<String, dynamic>> profileList = [
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Aiony',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1464863979621-258859e62245?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Alexa',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fGZha2UlMjBtYW4lMjB3b21hbnxlbnwwfHwwfHx8MA%3D%3D',
      'name': 'Ian',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Aiony',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1464863979621-258859e62245?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Alexa',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fGZha2UlMjBtYW4lMjB3b21hbnxlbnwwfHwwfHx8MA%3D%3D',
      'name': 'Ian',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Aiony',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1464863979621-258859e62245?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Alexa',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fGZha2UlMjBtYW4lMjB3b21hbnxlbnwwfHwwfHx8MA%3D%3D',
      'name': 'Ian',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Aiony',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1464863979621-258859e62245?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmFrZSUyMG1hbiUyMHdvbWFufGVufDB8fDB8fHww',
      'name': 'Alexa',
      'msg': 'In ullamco cupidatat'
    },
    {
      'imgUrl':
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fGZha2UlMjBtYW4lMjB3b21hbnxlbnwwfHwwfHx8MA%3D%3D',
      'name': 'Ian',
      'msg': 'In ullamco cupidatat'
    },
  ];
  bool snackBarCalled = false;
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.03, vertical: mWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chat App',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: mWidth * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.search),
                        InkWell(
                            onTap: () async {
                              await context.read<ChatService>().signOut();
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                            },
                            child: const Icon(Icons.logout)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: profileList.length,
                itemBuilder: (context, index) {
                  return index == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    )),
                                alignment: Alignment.center,
                                width: 60,
                                height: 60,
                                child: Icon(
                                  Icons.add,
                                )),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  profileList[index]['imgUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              profileList[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: mWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.more_horiz)
                ],
              ),
            ),
            SizedBox(
              height: mHeight * 0.03,
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mWidth * 0.03),
                  child: FutureBuilder<List<RegisterModel>>(
                    future: context.read<ChatService>().getAllUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var currUsers = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ChatPage(
                                    name: currUsers.uName,
                                    toId: currUsers.uid!,
                                  );
                                },
                              ));
                            },
                            child: MsgTitle(
                              imgUrl: snapshot.data![index].uProfilePic,
                              name: snapshot.data![index].uName,
                              msg: snapshot.data![index].uEmail,
                            ),
                          );
                        },
                      );
                    },
                  )),
            ),
          ],
        ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
