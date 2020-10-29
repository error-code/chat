import 'package:chat/components/home_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(new find());

class find extends StatefulWidget {
  @override
  _findState createState() => _findState();
}

class _findState extends State<find> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
            appBar: new HomeNavBar(title: '发现'),
            body: ListView(
                children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                        MenuListItem('朋友圈','icons_outlined_colorful_moment',null),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('视频号','icons_outlined_finder',Color(0xfffa9e3b)),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('扫一扫','icons_outlined_scan',Color(0xff1c83e0)),
                        MenuListItem('摇一摇','icons_outlined_shake',Color(0xff1c83e0)),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('看一看','icons_outlined_news',Color(0xffffc300)),
                        MenuListItem('搜一搜','icons_outlined_search_logo',Color(0xfffa5251)),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('附近的人','icons_outlined_nearby',Color(0xff1485ef)),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('购物','icons_outlined_searchicon_shop',Color(0xfffa5252)),
                        MenuListItem('游戏','icons_outlined_colorful_game',null),
                        Padding(
                            padding:EdgeInsets.only(top:15)
                        ),
                        MenuListItem('小程序','icons_outlined_mini_program2',Color(0xff6868e2)),
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
                        EasyLoading.showToast('敬请期待',duration:Duration(
                            milliseconds:1000
                        ));
                        // Application.router.navigateTo(context, "/chat");
                    },
                ),
            )
        );
    }
}