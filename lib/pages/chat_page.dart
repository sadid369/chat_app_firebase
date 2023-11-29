// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chat_app_firebase/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  // final ChatService _chatService = ChatService();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;
  File? imgUrl;
  String? pickedImageUrl;
  bool isTextFieldEmpty = false;
  @override
  void initState() {
    super.initState();
  }

  Future<void> pickedImage() async {
    final ImagePicker imagePicker = ImagePicker();

    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imgUrl = File(pickedImage.path);
      setState(() {});
    }
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
              stream: context.read<ChatService>().getAllMessages(widget.toId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
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
          IconButton(
              onPressed: () {
                pickedImage().then((value) {
                  if (imgUrl != null) {
                    showGeneralDialog(
                      barrierLabel: 'Custom',
                      barrierDismissible: true,
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Center(
                          child: Container(
                              height: 300,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        child: Image.file(
                                          imgUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.black),
                                                  onPressed: () {
                                                    context
                                                        .read<ChatService>()
                                                        .sendImage(imgUrl,
                                                            widget.toId);
                                                    imgUrl == null;
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text('Photo'),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(Icons.send),
                                                    ],
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black),
                                                onPressed: () {
                                                  imgUrl == null;
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    );
                  }
                });
              },
              icon: const Icon(
                Icons.attach_file,
              )),
          Expanded(
            child: TextField(
              onChanged: (value) {
                value.isEmpty
                    ? isTextFieldEmpty = false
                    : isTextFieldEmpty = true;
                setState(() {});
              },
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                hintText: 'Enter Message',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          isTextFieldEmpty
              ? IconButton(
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
                )
              : IconButton(
                  onPressed: null,
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
