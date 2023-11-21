// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MsgTitle extends StatefulWidget {
  String imgUrl;
  String name;
  String msg;

  MsgTitle({
    Key? key,
    required this.imgUrl,
    required this.name,
    required this.msg,
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
                      widget.imgUrl.isEmpty
                          ? "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=338&ext=jpg&ga=GA1.1.44546679.1698969600&semt=ais"
                          : widget.imgUrl,
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
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //actual msg summary
                  Text(
                    widget.msg,
                    style: TextStyle(
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
              Text('02:11'),
              Container(
                alignment: Alignment.center,
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber.shade500,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
