/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:chat/config/route_handlers.dart';

class Routes {
    static String root = "/";
    static String chat = "/chat";
    static String search = "/search";
    static String demoSimpleFixedTrans = "/demo/fixedtrans";
    static String demoFunc = "/demo/func";
    static String deepLink = "/message";

    static void configureRoutes(FluroRouter router) {
        router.notFoundHandler = Handler(
            handlerFunc: (BuildContext context, Map<String, List<String>> params) {
                print("ROUTE WAS NOT FOUND !!!");
            }
        );
        router.define(root, handler: rootHandler);
        router.define(chat, handler: chatHandler,transitionType: TransitionType.cupertino);
        router.define(search, handler: searchHandler,transitionType: TransitionType.cupertino);
        // router.define(demoSimpleFixedTrans,
        //     handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
        // router.define(demoFunc, handler: demoFunctionHandler);
        // router.define(deepLink, handler: deepLinkHandler);
    }
}
