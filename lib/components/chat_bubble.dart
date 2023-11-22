// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_firebase/model/message.dart';
import 'package:chat_app_firebase/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  final Message message;

  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    var currUserId = ChatService.currentUserId;
    return widget.message.fromId == currUserId
        ? fromMsgWidget()
        : toMsgWidget();
  }

  Widget fromMsgWidget() {
    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.message.sent)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.all(11),
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomLeft: Radius.circular(21),
              ),
            ),
            child: Text(widget.message.message),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text('${sentTime.format(context)}'),
        )
      ],
    );
  }

  Widget toMsgWidget() {
    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.message.sent)));
    return Row(
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.all(11),
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomRight: Radius.circular(21),
              ),
            ),
            child: Text(widget.message.message),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text('${sentTime.format(context)}'),
        )
      ],
    );
  }
}
