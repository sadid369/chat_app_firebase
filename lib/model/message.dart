// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String fromId;
  String mId;
  String message;
  String magType;
  String read;
  String sent;
  String toId;
  Message({
    required this.fromId,
    required this.mId,
    required this.message,
    this.magType = 'text',
    this.read = "",
    required this.sent,
    required this.toId,
  });

  Message copyWith({
    String? fromId,
    String? mId,
    String? message,
    String? magType,
    String? read,
    String? sent,
    String? toId,
  }) {
    return Message(
      fromId: fromId ?? this.fromId,
      mId: mId ?? this.mId,
      message: message ?? this.message,
      magType: magType ?? this.magType,
      read: read ?? this.read,
      sent: sent ?? this.sent,
      toId: toId ?? this.toId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromId': fromId,
      'mId': mId,
      'message': message,
      'magType': magType,
      'read': read,
      'sent': sent,
      'toId': toId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      fromId: map['fromId'] as String,
      mId: map['mId'] as String,
      message: map['message'] as String,
      magType: map['magType'] as String,
      read: map['read'] as String,
      sent: map['sent'] as String,
      toId: map['toId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(fromId: $fromId, mId: $mId, message: $message, magType: $magType, read: $read, sent: $sent, toId: $toId)';
  }
}
