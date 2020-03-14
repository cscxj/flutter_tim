import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/message_page/auto_app_bar.dart';
import 'package:flutter_tim/pages/message_page/message_item.dart';
import 'package:flutter_tim/widgets/fake_search_bar.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

enum AppBarState {
  show,
  hide,
}

class _MessagePageState extends State<MessagePage> {
  AutoAppBarControler _appBarControler;
  ScrollController _scrollController;

  AppBarState _appBarState = AppBarState.show;

  @override
  void initState() {
    _appBarControler = new AutoAppBarControler();
    super.initState();
    _scrollController = new ScrollController()
      ..addListener(() {
        // 因为滑动速度慢的时候appbar不会变化，防止滑到顶端还隐藏appBar
        if (_scrollController.position.pixels <
                MediaQuery.of(context).padding.top + 48 &&
            _appBarState == AppBarState.hide) {
          _appBarControler.show(); // 显示appBar
          _appBarState = AppBarState.show;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AutoAppBar(
        controler: _appBarControler,
        title: '消息',
        leftIcon: SvgPicture.asset(
          'assets/svg/lianXiRen.svg',
          color: Colors.white,
          width: 20,
        ),
        rightIcon: SvgPicture.asset(
          'assets/svg/add.svg',
          color: Colors.white,
          width: 20,
        ),
      ),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawerEdgeDragWidth: 300.0,
      body: Listener(
          onPointerMove: (e) {
            double speed = e.delta.dy; // 这个可以当做滚动的速度
            if (speed > 5.0 && _appBarState == AppBarState.hide) {
              _appBarControler.show();
              _appBarState = AppBarState.show;
            } else if (e.delta.dy < -5.0 && _appBarState == AppBarState.show) {
              _appBarControler.hide();
              _appBarState = AppBarState.hide;
            }
          },
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              FakeSearchBar(),
              ...List.generate(20, (index) {
                return MessageItem();
              })
            ],
          )),
    );
  }
}
