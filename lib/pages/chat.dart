import 'package:chat/input/my_special_text_span_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:chat/components/chat_panel.dart';
import 'package:extended_text/extended_text.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new chat());

class chat extends StatefulWidget {
    @override
    _chatState createState() => _chatState();
}

class _chatState extends State<chat> {

    List list = [
        {"nickname":"明月","avatar":"/20201025/1da3e8513446deb3c6d688a1d679ed85.jpg","msg_type":"text","content":"你好啊","is_mine":false},
        {"nickname":"接待员-段丽娜","avatar":"/20201022/073dc7d869a331f90ae03690780b5f5d.png","msg_type":"text","content":"哦哦","is_mine":true},
        {"nickname":"明月","avatar":"/20201025/1da3e8513446deb3c6d688a1d679ed85.jpg","msg_type":"text","content":"吃饭没得","is_mine":false},
        {"nickname":"明月","avatar":"/20201025/1da3e8513446deb3c6d688a1d679ed85.jpg","msg_type":"text","content":"有空没啊","is_mine":false},
        {"nickname":"明月","avatar":"/20201025/1da3e8513446deb3c6d688a1d679ed85.jpg","msg_type":"text","content":"有时间吗","is_mine":false},
        {"nickname":"明月","avatar":"/20201025/1da3e8513446deb3c6d688a1d679ed85.jpg","msg_type":"text","content":"100万的项目玩不玩","is_mine":false},
        {"nickname":"接待员-段丽娜","avatar":"/20201022/073dc7d869a331f90ae03690780b5f5d.png","msg_type":"text","content":"呵呵呵","is_mine":true},
    ];
    ScrollController _controller = new ScrollController();

    @override
    void initState() {
        super.initState();
        /*
        EasyLoading.show(status: 'loading...');
        new Future.delayed(Duration(seconds: 1), () {
        //EasyLoading.dismiss();
        EasyLoading.showToast('Toast');
        });
        */
        
    }

    @override
    void dispose() {
        //为了避免内存泄露，需要调用_controller.dispose
        _controller.dispose();
        super.dispose();
    }

    void send(text){
        setState(() {
            list.add({
               "nickname":"接待员-段丽娜",
               "avatar":"/20201022/073dc7d869a331f90ae03690780b5f5d.png",
               "msg_type":"text",
               "content":text,
               "is_mine":true
            });
        });
        scrollBottom();
    }

    void scrollBottom(){
        Future.delayed(Duration(milliseconds: 50), () {
            _controller.jumpTo(_controller.position.maxScrollExtent);
        });
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: new AppBar(
                title:Text('聊天'),
                actions: [
                    Container(
                        padding: EdgeInsets.only(right:10),
                        child: InkWell(
                            child: Icon(Icons.more_horiz),
                        )
                    )
                ],
            ),
            body: new Container(
                color: Color(0xffededed),
                child: Column(
                    children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount:list.length,
                                controller: _controller,
                                itemBuilder: (context,index){
                                    return MessageItem(list[index]);
                                }
                            ),
                        ),
                        ChatPanel(
                            handle: (e){
                                this.send(e);
                            },
                        )
                    ],
                ),
            ),
        );
    }

    Widget MessageItem(msg){
        return Container(
            padding: EdgeInsets.all(10),
            child:msg['is_mine']==true?Row(
                children: [
                    Expanded(
                        flex:1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                MessageWrap(msg)
                            ],
                        )
                    ),
                    avatar(msg['avatar'])
                ],
            ):Row(
                children: [
                    avatar(msg['avatar']),
                    Expanded(
                        flex:1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                MessageWrap(msg)
                            ],
                        )
                    )
                ],
            )
        );        
    }

    Widget avatar(avatar){
        return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xffdddddd),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                image: DecorationImage(
                    image: NetworkImage('http://www.zqb666.vip/uploads/avatar$avatar')
                )
            ),
        );
    }

    Widget MessageWrap(msg){
        if(msg['msg_type']=='text'){
            final MySpecialTextSpanBuilder _mySpecialTextSpanBuilder = MySpecialTextSpanBuilder();
            final Widget text = ExtendedText(
                msg['content'],
                // textAlign: left ? TextAlign.left : TextAlign.right,
                specialTextSpanBuilder: _mySpecialTextSpanBuilder,
                onSpecialTextTap: (dynamic value) {
                    if (value.toString().startsWith('\$')) {
                        launch('https://github.com/fluttercandies');
                    } else if (value.toString().startsWith('@')) {
                        launch('mailto:zmtzawqlp@live.com');
                    }
                },
            );
            return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: msg['is_mine']==true?Color(0xff07c160):Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: text,
            );
        }else{
            return null;
        }
    }
}
