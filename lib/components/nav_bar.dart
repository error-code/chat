import 'package:flutter/material.dart';

void main() {
  NavBar();
}

class NavBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  BuildContext context;
  final List<Widget> actions;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final String backImgName;
  final bool isBack;

  NavBar({
    this.title,
    this.context,
    this.actions,
    this.titleStyle,
    this.backgroundColor,
    this.backImgName,
    this.isBack: false,
  });

  @override
  _NavBarState createState() => _NavBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(55);
}

class _NavBarState extends State<NavBar> {

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
      actions: widget.actions,
    );
  }
}
