import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim/entities/chat_message.dart';

class ChatMessageView extends StatefulWidget {
  ChatMessageView({Key key, this.isShowName: false, @required this.message})
      : assert(message != null),
        super(key: key);

  final bool isShowName;
  final ChatMessage message;

  @override
  _ChatMessageViewState createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends State<ChatMessageView> {
  Widget getPicture() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipOval(
        child: Image.asset(widget.message.picture, width: 40.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: widget.message.isMeSend
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          widget.message.isMeSend ? Container() : getPicture(),
          Column(
            crossAxisAlignment: widget.message.isMeSend
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              widget.isShowName
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Text('${widget.message.sender}:',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black.withOpacity(.7))),
                    )
                  : Container(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 260.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(widget.message.content,style: TextStyle(fontSize: 16.0),), //暂时只支持文本，支持其他在这里改
                ),
              )
            ],
          ),
          widget.message.isMeSend ? getPicture() : Container()
        ],
      ),
    );
  }
}
