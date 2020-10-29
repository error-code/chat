import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:chat/config/application.dart';
import 'package:chat/config/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
    runApp(MyApp());
    if (Platform.isAndroid) {
        //沉浸式状态栏
        //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏，写在渲染之前对MaterialApp组件会覆盖这个值。
        SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
}

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    _MyAppState(){
        final router = FluroRouter();
        Routes.configureRoutes(router);
        Application.router = router;
    }

    @override
    Widget build(BuildContext context) {
        final app = MaterialApp(
            title: '聊天',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //     primarySwatch: Colors.blue,
            // ),
            onGenerateRoute: Application.router.generator,
            builder: (BuildContext context, Widget child) {
                /// 确保 loading 组件能覆盖在其他组件之上.
                return FlutterEasyLoading(child: child);
            },
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                    brightness:Brightness.light,
                    elevation: 1,
                    color: Color(0xffededed),
                    // centerTitle:true,
                    iconTheme:IconThemeData(
                        color: Color(0xff141414)
                    ),
                    textTheme: TextTheme(
                        headline6: TextStyle(color: Color(0xff141414),fontSize: 18.0)
                    )
                )
            ),
        );
        return app;
    }
}
