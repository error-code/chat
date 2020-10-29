import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'BottomPages/home.dart';
import 'BottomPages/contact.dart';
import 'BottomPages/find.dart';
import 'BottomPages/mine.dart';
import 'BottomPages/game.dart';

void main() {
    runApp(HomePage());
}

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

    int activeIndex = 0;
    PageController _pageController;
    Color selectColor = Color(0xff07c160);
    Color unSelectColor = Colors.black;
    List<Widget> pages = [
        home(), 
        contact(),
        // game(), 
        find(), 
        mine()
    ];

    @override
    void initState() {
        super.initState();
        _pageController = PageController();
        // List _list = buildBottom();
        // print(_list);
    }

    @override
    void dispose() {
        _pageController.dispose();
        super.dispose();
    }

    Widget SvgLoad(svg,index){
        if(index==activeIndex){
            return SvgPicture.asset('assets/svg/icons_filled_$svg.svg',color: selectColor);
        }else{
            return SvgPicture.asset('assets/svg/icons_outlined_$svg.svg',color: unSelectColor);
        }
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            body: PageView(
                children: pages,
                controller: _pageController,
                onPageChanged: (index) {
                    setState(() {
                        activeIndex = index;
                    });
                },
                physics: NeverScrollableScrollPhysics() //取消滑动
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: selectColor,
                unselectedItemColor: unSelectColor,
                items: [
                    BottomNavigationBarItem(
                        icon: SvgLoad('chats',0), 
                        label:'聊天'
                    ),
                    BottomNavigationBarItem(
                        icon: SvgLoad('contacts',1),
                        label:'通讯录'
                    ),
                    // BottomNavigationBarItem(
                    //     icon: SvgLoad('fire',3),
                    //     label:'游戏大厅'
                    // ),
                    BottomNavigationBarItem(
                        icon: SvgLoad('discover',2),
                        label:'发现'
                    ),
                    BottomNavigationBarItem(
                        icon: SvgLoad('me',3),
                        label:'我'
                    ),
                ],
                onTap: (value) {
                    if (_pageController.hasClients) {
                        _pageController.jumpToPage(value);
                    }
                    setState(() {
                        activeIndex = value;
                    });
                },
                currentIndex: activeIndex,
            )
        );
    }
}
