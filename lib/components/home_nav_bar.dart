import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:chat/config/application.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
    HomeNavBar();
}

class HomeNavBar extends StatefulWidget implements PreferredSizeWidget {

    final String title;
    BuildContext context;
    final List<Widget> actions;
    final TextStyle titleStyle;
    final Color backgroundColor;
    final String backImgName;
    final bool isBack;

    HomeNavBar({
        this.title,
        this.context,
        this.actions,
        this.titleStyle,
        this.backgroundColor,
        this.backImgName,
        this.isBack: false,
    });

    @override
    _HomeNavBarState createState() => _HomeNavBarState();

    @override
    Size get preferredSize => Size.fromHeight(55);
}

class _HomeNavBarState extends State<HomeNavBar> {

    @override
    Widget build(BuildContext context) {
        return AppBar(
            title: new Text(
                widget.title ?? 'title',
                style: widget.titleStyle ?? new TextStyle(
                    color: Color.fromARGB(255, 23, 23, 23),
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                ),
            ),
            
            leading: widget.isBack ? InkWell(
                child: Icon(Icons.arrow_back,color: Color.fromARGB(255, 23, 23, 23),),
                onTap: () {
                    Navigator.pop(context);
                },
            ) : null,
            automaticallyImplyLeading: widget.isBack?true:false,
            backgroundColor: widget.backgroundColor ?? Color.fromARGB(255, 237, 237, 237),
            elevation: 1,
            actions: [
                IconButton(
                    icon: Icon(Icons.search,color: Colors.black), 
                    tooltip: '搜索',
                    onPressed: (){
                        Application.router.navigateTo(context, '/search',transition: TransitionType.none);
                    }
                ),
                IconButton(
                    icon: Icon(Icons.add_circle_outline,color: Colors.black), 
                    tooltip: '添加',
                    onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                                return SimpleDialog(
                                    // title: Text('选择'),
                                    children: [
                                        SimpleDialogOption(
                                            onPressed: () {
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                child: Row(
                                                    children: [
                                                        SvgPicture.asset('assets/svg/icons_filled_chats.svg'),
                                                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                                        Text('发起群聊')
                                                    ],
                                                ),
                                            ),
                                        ),
                                        SimpleDialogOption(
                                            onPressed: () {
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                child: Row(
                                                    children: [
                                                        SvgPicture.asset('assets/svg/icons_filled_add_friends.svg'),
                                                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                                        Text('添加朋友')
                                                    ],
                                                ),
                                            ),
                                        ),
                                        SimpleDialogOption(
                                            onPressed: () {
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                child: Row(
                                                    children: [
                                                        SvgPicture.asset('assets/svg/icons_filled_scan.svg'),
                                                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                                        Text('扫一扫')
                                                    ],
                                                ),
                                            ),
                                        ),
                                    ],
                                );
                            }
                        );
                    }
                )
            ],
        );
    }
}
