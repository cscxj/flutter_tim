import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/contacts_page.dart';
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

    _scrollController = new ScrollController()..addListener(_appBarListener);
  }

  double preOffset = 0.0;
  double offset = 0.0;

  void _appBarListener() {
    if (_scrollController.offset < _scrollController.position.maxScrollExtent) {
      preOffset = offset;
      offset = _scrollController.offset;
      if (offset - preOffset > 3.0) {
        _appBarControler.hide();
        _appBarState = AppBarState.hide;
      } else if (offset - preOffset < -3.0) {
        _appBarControler.show();
        _appBarState = AppBarState.show;
      }
    }
    // 因为滑动速度慢的时候appbar不会变化，防止滑到顶端还隐藏appBar
    if (_scrollController.offset <
            MediaQuery.of(context).padding.top + 48 + 80 &&
        _appBarState == AppBarState.hide) {
      _appBarControler.show(); // 显示appBar
      _appBarState = AppBarState.show;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AutoAppBar(
        controler: _appBarControler,
        title: '消息',
        leftIcon: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ContactsPage();
            }));
          },
          child: SvgPicture.asset(
            'assets/svg/tim_contact.svg',
            color: Colors.white,
            width: 40,
          ),
        ),
        rightIcon: InkWell(
          onTap: (){
            // Navigator.push(context, CupertinoPageRoute(builder: (_){
            //   return TestPage2();
            // }));
          },
          child: SvgPicture.asset(
          'assets/svg/tim_add.svg',
          color: Colors.white,
          width: 40,
        ), )
      ),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawerEdgeDragWidth: 300.0,
      body: ListView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          FakeSearchBar(),
          ...List.generate(20, (index) {
            return MessageItem();
          })
        ],
      ),
    );
  }
}

