import 'package:flutter/material.dart';
import 'package:flutter_tim/entities/contact_group.dart';
import 'package:sticky_headers/sticky_headers.dart';

class GroupItem extends StatefulWidget {
  final ContactGroup data;

  const GroupItem({Key key, @required this.data})
      : assert(data != null, '联系人列表组件需要传入数据'),
        super(key: key);
  @override
  _GroupItemState createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: FlatButton(
        color: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              widget.data.display = !widget.data.display;
            });
          },
          child: Container(
            height: 40.0,
            child: Row(
              children: <Widget>[
                Icon(
                  widget.data.display
                      ? Icons.arrow_drop_down
                      : Icons.arrow_right,
                  color: Color(0xff666666),
                  size: 24,
                ),
                Text(
                  widget.data.groupName,
                  style: TextStyle(fontSize: 16.0),
                ),
                Expanded(child: Container()),
                Text(
                  '${widget.data.activeCount}/${widget.data.contactList.length}',
                  style: TextStyle(fontSize: 12.0, color: Color(0xff666666)),
                )
              ],
            ),
          )),
      content: widget.data.display
          ? ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: widget.data.contactList.map((contact) {
                return FlatButton(
                    onPressed: () {},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(horizontal: .0),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: ClipOval(
                                child: Image.asset(
                                  contact.picture,
                                  width: 48.0,
                                  height: 48.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(child: Text(contact.name))
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        indent: 60.0,
                      )
                    ]));
              }).toList(),
            )
          : Container(),
    );
  }
}
