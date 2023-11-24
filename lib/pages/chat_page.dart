// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_firebase/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app_firebase/components/chat_bubble.dart';
import 'package:chat_app_firebase/components/my_text_field.dart';
import 'package:chat_app_firebase/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String toId;
  const ChatPage({
    Key? key,
    required this.name,
    required this.toId,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;

  @override
  void initState() {
    super.initState();
  }

<<<<<<< HEAD
  getChatStream() {
    chatStream = context.read<ChatService>().getAllMessages(widget.toId);
=======
  getChatStream() async {
    chatStream = await context.read<ChatService>().getAllMessages(widget.toId);
>>>>>>> 0b6838c13a9322fbe9ccda85ec1b2289f840c438
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
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
                        const Icon(Icons.video_call_rounded),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.call),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder(
<<<<<<< HEAD
              stream: context.read<ChatService>().getAllMessages(widget.toId),
=======
              stream: chatStream,
>>>>>>> 0b6838c13a9322fbe9ccda85ec1b2289f840c438
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
<<<<<<< HEAD
                  var allMessages = snapshot.data!.docs;
                  return allMessages.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var currMsg =
                                Message.fromMap(allMessages[index].data());
                            return ChatBubble(message: currMsg);
                          },
                        )
                      : Container();
=======
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '${Message.fromMap(snapshot.data!.docs[index].data()).message}'),
                      );
                    },
                  );
>>>>>>> 0b6838c13a9322fbe9ccda85ec1b2289f840c438
                }
                return Container();
              },
            )),
            _buildMessageInput(),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
                controller: _messageController,
                hintText: 'Enter Message',
                obscureText: false),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<ChatService>()
                  .sendMessage(_messageController.text, widget.toId);
              _messageController.text = "";
            },
            icon: const Icon(
              Icons.send,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
