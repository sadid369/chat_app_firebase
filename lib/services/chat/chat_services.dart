import 'package:chat_app_firebase/model/message.dart';
import 'package:chat_app_firebase/model/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static String currentUserId = _firebaseAuth.currentUser!.uid;

  Future<List<RegisterModel>> getAllUser() async {
    List<RegisterModel> users = [];

    var arrUsersData = await _firebaseFirestore.collection('users').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> user
        in arrUsersData.docs) {
      var dataModel = RegisterModel.fromMap(user.data());
      if (dataModel.uid != _firebaseAuth.currentUser!.uid) {
        users.add(RegisterModel.fromMap(user.data()));
      }
    }
    return users;
  }

  List<String> createChatId(String fromId, String toId) {
    return ['${fromId}_${toId}', '${fromId}_${toId}'];
  }

  Future<String> checkIfChatExists(String fromId, String toId) async {
    var allChatRoom = await _firebaseFirestore.collection('chatroom').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> eachChat
        in allChatRoom.docs) {
      if (createChatId(fromId, toId).contains(eachChat.id)) {
        return eachChat.id;
      }
    }
    return '';
  }

  void sendMessage(String msg, String toId) async {
    var chatId = await checkIfChatExists(currentUserId, toId);
    var sentTime = DateTime.now().millisecondsSinceEpoch;
    var newMessage = Message(
        fromId: currentUserId,
        mId: sentTime.toString(),
        message: msg,
        sent: sentTime.toString(),
        toId: toId);
    if (chatId != "") {
      _firebaseFirestore
          .collection('chatroom')
          .doc(chatId)
          .collection('messages')
          .doc(sentTime.toString())
          .set(newMessage.toMap());
    } else {
      _firebaseFirestore
          .collection('chatroom')
          .doc(createChatId(newMessage.fromId, newMessage.toId)[0])
          .collection('messages')
          .doc(sentTime.toString())
          .set(newMessage.toMap());
    }
  }
}
