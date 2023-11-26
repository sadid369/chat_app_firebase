import 'package:chat_app_firebase/model/message.dart';
import 'package:chat_app_firebase/model/register.dart';
import 'package:chat_app_firebase/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static String currentUserId = firebaseAuth.currentUser!.uid;
  Future<void> signInWithEmailandPassword(
      String email, String password, BuildContext context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ));
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailandPassword(
      {required RegisterModel user}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.uEmail, password: user.uPassword);

      firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.copyWith(uid: userCredential.user!.uid).toMap());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<List<RegisterModel>> getAllUser() async {
    List<RegisterModel> users = [];

    var arrUsersData = await firebaseFirestore.collection('users').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> user
        in arrUsersData.docs) {
      var dataModel = RegisterModel.fromMap(user.data());
      if (dataModel.uid != firebaseAuth.currentUser!.uid) {
        users.add(RegisterModel.fromMap(user.data()));
      }
    }
    return users;
  }

  String getChatID(String fromId, String toId) {
    if (fromId.hashCode <= toId.hashCode) {
      return "${fromId}_$toId";
    } else {
      return "${toId}_$fromId";
    }
  }

  void sendMessage(String msg, String toId) {
    var chatId = getChatID(currentUserId, toId);
    var sentTime = DateTime.now().millisecondsSinceEpoch;
    var newMessage = Message(
        fromId: currentUserId,
        mId: sentTime.toString(),
        message: msg,
        sent: sentTime.toString(),
        toId: toId);

    firebaseFirestore
        .collection('chatroom')
        .doc(chatId)
        .collection('messages')
        .doc(sentTime.toString())
        .set(newMessage.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(String toId) {
    var chatId = getChatID(currentUserId, toId);
    print('Chat id: $chatId');
    return firebaseFirestore
        .collection('chatroom')
        .doc(chatId)
        .collection('messages')
        .snapshots();
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  void updateReadTime(String mid, String fromId) {
    var chatId = getChatID(currentUserId, fromId);
    var readTime = DateTime.now().millisecondsSinceEpoch;
    firebaseFirestore
        .collection('chatroom')
        .doc(chatId)
        .collection('messages')
        .doc(mid)
        .update({'read': readTime.toString()});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatLstMsg(String toId) {
    var chatId = getChatID(currentUserId, toId);
    return firebaseFirestore
        .collection('chatroom')
        .doc(chatId)
        .collection("messages")
        .orderBy("sent", descending: true)
        .limit(1)
        .snapshots();
  }
}
