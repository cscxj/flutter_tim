import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  ScrollController _controller;
  double _buttonWidth = 80.0;
  double _height = 70.0;

  List<Widget> buttons = [];

  Widget getHideButton({Color bgColor, String title, Color titleColor}) {
    return Container(
      width: _buttonWidth,
      height: _height,
      alignment: Alignment.center,
      color: bgColor ?? Colors.black12,
      child: Text(
        title ?? '',
        style: TextStyle(color: titleColor ?? Colors.white),
      ),
    );
  }

  initUI() {
    buttons = [
      getHideButton(bgColor: Colors.red, title: '删除'),
      getHideButton(title: '置顶')
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    initUI();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _filpToLeft() {
    _controller.animateTo(buttons.length * _buttonWidth,
        duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  void _filpToRight() {
    _controller.animateTo(0.0,
        duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  double _tapDownPostion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Listener(
        onPointerDown: (e) {
          _tapDownPostion = e.position.dx;
        },
        onPointerUp: (e) {
          double offset = e.position.dx - _tapDownPostion;

          if (offset > 0.0 && _controller.offset != 0.0) {
            // 在最左端时，向右滑无效
            // 向右滑
            offset > 60.0 ? _filpToRight() : _filpToLeft();
          } else if (offset < 0.0 &&
              _controller.offset != buttons.length * _buttonWidth) {
            // 在最右端时，向左滑无效
            // 向左滑
            offset > -60.0 ? _filpToRight() : _filpToLeft();
          }
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: <Widget>[
                    // 头像
                    ClipOval(
                      child: Image.asset(
                        'assets/touXiang.jpg',
                        fit: BoxFit.cover,
                        width: 50,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Flutter技术交流群',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '17:38',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '吃了吗',
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.remove_circle)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 隐藏按钮
              ...buttons
            ],
          ),
        ),
      ),
    );
  }
}
