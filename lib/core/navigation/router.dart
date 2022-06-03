import 'package:flutter/material.dart';
import 'package:swapy/screens/chat_room/screen/chat.dart';
import 'package:swapy/screens/chat/screen/chat_detail.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/screen/home.dart';
import 'package:swapy/screens/login/screen/after_login.dart';
import 'package:swapy/screens/login/screen/login.dart';
import 'package:swapy/screens/onboard/screen/onboard.dart';
import 'package:swapy/screens/product_detail/screen/product_detail.dart';
import 'package:swapy/screens/register/screen/register.dart';

class AppRouter {
  static const String onBoard = '/';
  static const String login = '/login';
  static const String afterLogin = '/after-login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productDetail = '/product-detail';
  static const String chat = '/chat';
  static const String chatDetail = '/chat-detail';

  static MaterialPageRoute<Object>? generateRoute(RouteSettings routeSettings, {Widget? route}) {
    return MaterialPageRoute(builder: (context) => getPage(routeSettings));
  }

  static Widget getPage(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return Onboard();
      case '/login':
        return Login();
      case '/after-login':
        return AfterLogin();
      case '/register':
        return Register();
      case '/home':
        return Home();
      case '/product-detail':
        return ProductDetail(toy: settings.arguments as Toy,);
      case '/chat':
        return ChatUsers();
      case '/chat-detail':
        return ChatDetail();
      default:
        return Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        );
    }
  }
}
