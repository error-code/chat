import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(){
    runApp(game());
}

class game extends StatefulWidget {

    @override
    _gameState createState() => _gameState();
}

class _gameState extends State<game> with AutomaticKeepAliveClientMixin{

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        // Enable hybrid composition.
        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
        print('加载');
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: WebView(
                initialUrl: 'http://www.guopi.xin',
                javascriptMode:JavascriptMode.unrestricted
            )
        );
    }
}