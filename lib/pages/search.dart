import 'package:flutter/material.dart';

class search extends StatefulWidget {
    @override
    _searchState createState() => _searchState();
}

class _searchState extends State<search> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar:AppBar(
                title: new SearchBar(),
                backgroundColor: Color.fromARGB(255, 237, 237, 237),
                leading: null,
                automaticallyImplyLeading: false,
                elevation: 1,
            ),
            body: Container(
                child: Center(
                    child: Text('搜索好友'),
                ),
            ),
        );
    }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget{

    @override
    _SearchBarState createState() => _SearchBarState();

    @override
    // TODO: implement preferredSize
    Size get preferredSize => Size.fromHeight(55);
}

class _SearchBarState extends State<SearchBar> {
    @override
    Widget build(BuildContext context) {
        return Container(
            child: Row(
                children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            decoration: new BoxDecoration(
                                // border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                            ),
                            child: TextField(
                                autofocus:true,
                                decoration: InputDecoration(
                                    border:OutlineInputBorder(
                                        borderSide:BorderSide.none
                                    ),
                                    hintText: '输入好友UID',
                                    hintStyle:TextStyle(color: Color(0xffacacac)),
                                    prefixIcon: Icon(Icons.search,color: Color(0xffacacac)),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.search,
                            ),
                            height: 35,
                        ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left:20),
                        child: InkWell(
                            child: Text(
                                '取消',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                            ),
                            onTap: (){
                                Navigator.of(context).pop();
                            },
                        )
                    )
                ],
            )
        );
    }
}