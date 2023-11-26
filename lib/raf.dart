// import 'package:chat_app_firebase/services/chat/chat_services.dart';
// import 'package:flutter/material.dart';
// import 'package:talklytic/firebase/firebase_provider.dart';
// import 'package:talklytic/model/message_model.dart';

// class ChatBubblesWidget extends StatefulWidget {
//   MessageModel msg;

//   ChatBubblesWidget({
//     required this.msg,
//   });

//   @override
//   State<ChatBubblesWidget> createState() => _ChatBubblesWidgetState();
// }

// class _ChatBubblesWidgetState extends State<ChatBubblesWidget> {
//   @override
//   Widget build(BuildContext context) {
//     var currUserId = FirebaseProvider.currUserId;

//     return widget.msg.fromId == currUserId ? fromMsgWidget() : toMsgWidget();
//   }

//   //yellow
//   Widget fromMsgWidget() {
//     var sentTime = TimeOfDay.fromDateTime(
//         DateTime.fromMillisecondsSinceEpoch(int.parse(widget.msg.sent)));
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: Text('${sentTime.format(context)}'),
//         ),
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Container(
//                 margin: EdgeInsets.all(11),
//                 padding: EdgeInsets.all(11),
//                 decoration: BoxDecoration(
//                     color: Colors.amber.shade100,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(21),
//                         topRight: Radius.circular(21),
//                         bottomLeft: Radius.circular(21))),
//                 child: Text(widget.msg.message),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Visibility(visible: widget.msg.read!="",
//                       child: Text(widget.msg.read=="" ? "" : TimeOfDay.fromDateTime(
//                           DateTime.fromMillisecondsSinceEpoch(int.parse(widget.msg.read))).format(context).toString())),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Icon(Icons.done_all_outlined,
//                       color: widget.msg.read!= "" ? Colors.blue : Colors.grey,),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   //blue
//   Widget toMsgWidget() {

//     ///updateReadStatus
//     if(widget.msg.read==""){
//       ChatService.updateReadTime(widget.msg.mId, widget.msg.fromId);
//     }


//     var sentTime = TimeOfDay.fromDateTime(
//         DateTime.fromMillisecondsSinceEpoch(int.parse(widget.msg.sent)));
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//           child: Container(
//             margin: EdgeInsets.all(11),
//             padding: EdgeInsets.all(11),
//             decoration: BoxDecoration(
//                 color: Colors.blue.shade100,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(21),
//                     topRight: Radius.circular(21),
//                     bottomRight: Radius.circular(21))),
//             child: Text(widget.msg.message),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0),
//           child: Text('${sentTime.format(context)}'),
//         ),
//       ],
//     );
//   }
// }