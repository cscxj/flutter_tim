import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tim/entities/contact_group.dart';
import 'package:flutter_tim/pages/contacts_page/group_item.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_tim/widgets/fake_search_bar.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Map<String, String>> subareaData = [
    {'icon': 'assets/svg/pengYou.svg', 'text': '新朋友'},
    {'icon': 'assets/svg/qun.svg', 'text': '群聊'},
    {'icon': 'assets/svg/minPian.svg', 'text': '名片夹'}
  ];
  List<ContactGroup> groups = [
    ContactGroup(
        groupName: '我的设备',
        activeCount: 5,
        contactList: [
          Contact(picture: 'assets/touXiang.jpg', name: '张三'),
          Contact(picture: 'assets/bg.png', name: '李四'),
          Contact(picture: 'assets/touXiang.jpg', name: '王五')
        ]),
    ContactGroup(
        groupName: '同学',
        activeCount: 5,
        contactList: [
          Contact(picture: 'assets/touXiang.jpg', name: '张三'),
          Contact(picture: 'assets/bg.png', name: '李四'),
          Contact(picture: 'assets/touXiang.jpg', name: '王五')
        ]),
    ContactGroup(
        groupName: '我的好友',
        activeCount: 5,
        contactList: [
          Contact(picture: 'assets/touXiang.jpg', name: '张三'),
          Contact(picture: 'assets/bg.png', name: '李四'),
          Contact(picture: 'assets/touXiang.jpg', name: '王五')
        ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfff6f7f9),
          centerTitle: true,
          leading: Center(
              child: Text(
            '添加',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          )),
          title: Text(
            '联系人',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            SvgPicture.asset(
              'assets/svg/arrow_right.svg',
              width: 20.0,
              color: Colors.black,
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (_, constrainters) {
          return Container(
            height: constrainters.maxHeight,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: <Widget>[
                  FakeSearchBar(),
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (_, index) {
                        return FlatButton(
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  subareaData[index]['icon'],
                                  width: 40,
                                ),
                                Padding(padding: EdgeInsets.only(top: 8)),
                                Text(subareaData[index]['text'])
                              ],
                            ));
                      }),
                  Divider(
                    height: .0,
                    thickness: .0,
                  ),
                  ...groups.map((data) {
                    return  GroupItem(data: data);
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
