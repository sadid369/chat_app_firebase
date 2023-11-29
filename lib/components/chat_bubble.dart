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

//yellow
  Widget fromMsgWidget() {
    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.message.sent)));
    // var readTime = TimeOfDay.fromDateTime(
    //     DateTime.fromMillisecondsSinceEpoch(int.parse(widget.message.read)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text('${sentTime.format(context)}'),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // width: 200,
                // height: 200,
                margin: const EdgeInsets.all(11),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: widget.message.magType == 'image'
                      ? Colors.white
                      : Colors.amber.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                    bottomLeft: Radius.circular(21),
                  ),
                ),
                child: widget.message.magType == 'image'
                    ? Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          widget.message.message,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(widget.message.message),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: widget.message.read != "",
                      child: Text(widget.message.read == ""
                          ? ""
                          : TimeOfDay.fromDateTime(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(widget.message.read)))
                              .format(context)
                              .toString())),
                  const SizedBox(
                    width: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.done_all_outlined,
                      color:
                          widget.message.read != "" ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

//blue
  Widget toMsgWidget() {
    if (widget.message.read == "") {
      context
          .read<ChatService>()
          .updateReadTime(widget.message.mId, widget.message.fromId);
    }
    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.message.sent)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // width: 200,
                // height: 200,
                margin: const EdgeInsets.all(11),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: widget.message.magType == 'image'
                      ? Colors.white
                      : Colors.blue.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                    bottomRight: Radius.circular(21),
                  ),
                ),
                child: widget.message.magType == 'image'
                    ? Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          widget.message.message,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(widget.message.message),
              ),
            ],
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
