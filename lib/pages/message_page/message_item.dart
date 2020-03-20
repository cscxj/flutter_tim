import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/chat_page.dart';
import 'package:flutter_tim/utils/scroll_behaviors.dart';

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
    _controller = ScrollController()..addListener(() {});
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

  Offset _tapDownPostion;
  double _speed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Listener(
        onPointerDown: (e) {
          _speed = .0;
          _tapDownPostion = e.position;
        },
        onPointerMove: (e) {
          _speed = e.delta.dx;
        },
        onPointerUp: (e) {
          double offset = e.position.dx - _tapDownPostion.dx;
          // 能向左滑的条件
          bool canScrollToLeft =
              _controller.offset != buttons.length * _buttonWidth &&
                  _controller.offset > 0.0;
          // 能向右滑的条件
          bool canScrollToRight = _controller.offset != 0.0 &&
              _controller.offset < buttons.length * _buttonWidth;
          if (_speed > 3.0 && canScrollToRight) {
            //速度较大的情况
            _filpToRight();
          } else if (_speed < -3.0 && canScrollToLeft) {
            _filpToLeft();
          } else {
            // 速度较小的情况
            if (offset > 0.0 && canScrollToRight) {
              offset > 60.0 ? _filpToRight() : _filpToLeft();
            } else if (offset < 0.0 && canScrollToLeft) {
              offset > -60.0 ? _filpToRight() : _filpToLeft();
            }
          }
        },
        child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              child: Row(
                children: <Widget>[
                  FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(context,
                            PageRouteBuilder(pageBuilder: (_, a, a1) {
                          return ChatPage();
                        }));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                      )),
                  // 隐藏按钮
                  ...buttons
                ],
              ),
            )),
      ),
    );
  }
}
