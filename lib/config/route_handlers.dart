/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:chat/HomePage.dart';
import 'package:chat/pages/chat.dart';
import 'package:chat/pages/search.dart';
import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});


var chatHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    /*
    String message = params["message"]?.first;
    String colorHex = params["color_hex"]?.first;
    String result = params["result"]?.first;
    Color color = Color(0xFFFFFFFF);
    if (colorHex != null && colorHex.length > 0) {
        color = Color(ColorHelpers.fromHexString(colorHex));
    }
    */
    return chat();
});

var searchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return search();
});