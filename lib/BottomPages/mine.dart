import 'dart:ui';
import 'package:chat/config/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(new mine());

class mine extends StatefulWidget {
    @override
    _mineState createState() => _mineState();
}

class _mineState extends State<mine> {
    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: new MineAppBar(),
            body: ListView(
                children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('钱包','icons_outlined_wallet',Color(0xff07c160)),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('积分','icons_outlined_colorful_cards',null),
                        MenuListItem('相册','icons_outlined_album',Color(0xff1f82e0)),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('举报','icons_outlined_error',Color(0xffe6a257)),
                        MenuListItem('设置','icons_outlined_setting',Color(0xff1485ef))
                    ]
                ).toList(),
            ),
        );
    }

    // ignore: non_constant_identifier_names
    Widget MenuListItem(title,svg,color){
        return new Material(
            child: Ink(
                child: InkWell(
                    child: Container(
                        height: 50,
                        padding: EdgeInsets.only(left:15,right:15),
                        color: Colors.white,
                        child: Row(
                            children: [
                                Container(
                                    child: SvgPicture.asset('assets/svg/$svg.svg',color: color!=null?color:null),
                                    padding: EdgeInsets.only(right:10),
                                ),
                                Expanded(
                                    flex:1,
                                    child: Text(title??'title'),
                                ),
                                Icon(Icons.keyboard_arrow_right,color: Color(0xffb2b2b2),)
                            ],
                        )
                    ),
                    onTap: (){
                        // Application.router.navigateTo(context, "/chat");
                    },
                ),
            )
        );
    }
}

class MineAppBar extends StatefulWidget implements PreferredSizeWidget {

    @override
    Size get preferredSize => Size.fromHeight(160);

    @override
    _MineAppBarState createState() => _MineAppBarState();
}

class _MineAppBarState extends State<MineAppBar> {
    @override
    Widget build(BuildContext context) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20,20,20,0),
            child: Column(
                children: [
                    Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: InkWell(
                            child: Icon(Icons.photo_camera),
                            onTap: (){
                                print('点击相机');
                            },
                        ),
                        alignment:AlignmentDirectional.centerEnd,
                    ),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(top:40),
                        child: Row(
                            children: [
                                Container(
                                    width:50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        image: DecorationImage(
                                            image: NetworkImage('http://www.zqb666.vip/uploads/avatar/20201022/073dc7d869a331f90ae03690780b5f5d.png')
                                            //image: Image.network('http://www.zqb666.vip/uploads/avatar/20201022/073dc7d869a331f90ae03690780b5f5d.png')
                                        )
                                    ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        padding: EdgeInsets.only(left:15),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                Container(
                                                    alignment: AlignmentDirectional.topStart,
                                                    child: Text(
                                                        'Mr.Yang',style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w800
                                                        )
                                                    ),
                                                ),
                                                Container(
                                                    child:Row(
                                                        children: [
                                                            Text('UID：1000000',style: TextStyle(color: Color(0xffaaaaaa))),
                                                            Expanded(
                                                                flex:1,
                                                                child:Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                        Icon(Icons.qr_code,color: Color(0xffaaaaaa)),
                                                                        Icon(Icons.keyboard_arrow_right,color: Color(0xffaaaaaa)),
                                                                    ],
                                                                ),
                                                            )
                                                        ],
                                                    )
                                                )
                                            ],
                                        )
                                    ),
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }
}