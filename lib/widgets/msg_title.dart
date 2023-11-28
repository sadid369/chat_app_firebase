// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_firebase/model/message.dart';
import 'package:chat_app_firebase/model/register.dart';
import 'package:chat_app_firebase/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class MsgTitle extends StatefulWidget {
  final RegisterModel user;
  final Message? msg;

  MsgTitle({
    Key? key,
    required this.user,
    this.msg,
  }) : super(key: key);

  @override
  _MsgTitleState createState() => _MsgTitleState();
}

class _MsgTitleState extends State<MsgTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //leading Image
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.user.uProfilePic.isEmpty
                          ? "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=338&ext=jpg&ga=GA1.1.44546679.1698969600&semt=ais"
                          : widget.user.uProfilePic,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              //body
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name of the person
                  Text(
                    widget.user.uName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //actual msg summary
                  widget.msg == null
                      ? Text(widget.user.uEmail)
                      : widget.msg!.magType == "image"
                          ? Icon(Icons.image_outlined)
                          : Text(
                              widget.msg!.message,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                ],
              ),
            ],
          ),

          //trialing
          Column(
            children: [
              widget.msg == null
                  ? Container()
                  : Text(
                      "${TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.msg!.sent))).format(context)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
              widget.msg != null ? showReadStatus(widget.msg!) : Container()
            ],
          )
        ],
      ),
    );
  }

  Widget showReadStatus(Message lastMsg) {
    if (lastMsg.fromId == ChatService.currentUserId) {
      return Icon(
        Icons.done_all_outlined,
        color: lastMsg.read != "" ? Colors.blue : Colors.grey,
      );
    } else {
      return Container();
    }
  }
}



//  Container(
//                 alignment: Alignment.center,
//                 width: 25,
//                 height: 25,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.amber.shade500,
//                 ),
//                 child: Text(
//                   '2',
//                   style: TextStyle(
//                     fontSize: 10,
//                   ),
//                 ),
//               )