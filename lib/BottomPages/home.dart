// import 'dart:ui';
import 'package:chat/components/home_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:chat/config/application.dart';

void main() => runApp(new home());

class home extends StatefulWidget {
    @override
    _homeState createState() => _homeState();
}

class _homeState extends State<home> {
    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: new HomeNavBar(title: '聊天'),
            body: Message()
        );
    }
}

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
    List<Map> data = [
        {
        'nickname': '明月',
        'msg': '哦哦',
        'time': '1小时前',
        'avatar':
            'http://www.zqb666.vip/uploads/avatar/20201025/1da3e8513446deb3c6d688a1d679ed85.jpg'
        },
        {
        'nickname': '接待员-段丽娜',
        'msg': '哦哦',
        'time': '1小时前',
        'avatar':
            'http://www.zqb666.vip/uploads/avatar/20201022/073dc7d869a331f90ae03690780b5f5d.png'
        },
        {
        'nickname': '我把梦丝了一夜',
        'msg': '哦哦',
        'time': '1小时前',
        'avatar':
            'http://www.zqb666.vip/uploads/avatar/20201025/e5ce9c7bd0c7a9cdab3fb5a611bdf399.jpg'
        },
    ];

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                    return ListItem(
                        nickname: data[index]['nickname'],
                        msg: data[index]['msg'],
                        time: data[index]['time'],
                        avatar: data[index]['avatar'],
                    );
                }
            )
        );
    }
}

class ListItem extends StatefulWidget {
    final String nickname;
    final String msg;
    final String time;
    final String avatar;
    ListItem({this.nickname, this.msg, this.time, this.avatar});

    @override
    _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
    @override
    Widget build(BuildContext context) {
        return new InkWell(
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            onTap: () {
                Application.router.navigateTo(context, "/chat");
            },
            onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                        return SimpleDialog(
                            // title: Text('选择'),
                            children: [
                                SimpleDialogOption(
                                onPressed: () {
                                    // 返回1
                                    Navigator.pop(context, 1);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: const Text('标为已读'),
                                ),
                                ),
                                SimpleDialogOption(
                                onPressed: () {
                                    // 返回1
                                    Navigator.pop(context, 1);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: const Text('置顶聊天'),
                                ),
                                ),
                                SimpleDialogOption(
                                onPressed: () {
                                    // 返回1
                                    Navigator.pop(context, 1);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: const Text('删除聊天',
                                        style: TextStyle(color: Colors.red)),
                                ),
                                ),
                            ],
                        );
                    }
                );
            },
            child: new Row(
            children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(widget.avatar, width: 50, height: 50)),
                Expanded(
                    flex: 1,
                    child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFeeeeee), width: 0.5))),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Row(
                        children: [
                            Expanded(
                            flex: 1,
                            child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(widget.nickname ?? 'title',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(
                                    widget.msg,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xFFacacac), fontSize: 12.0),
                                    ),
                                )
                                ],
                            ),
                            ),
                            Container(
                            child: new Text(widget.time,
                                style: TextStyle(
                                    color: Color(0xFFacacac), fontSize: 12.0)),
                            )
                        ],
                        ),
                    ),
                )
                )
            ],
            )
        );
    }
}
