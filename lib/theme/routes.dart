import 'package:flutter/material.dart';
import 'package:fittribe/views/login_screen.dart';
import 'package:fittribe/views/register_screen.dart';
import 'package:fittribe/views/menu.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),

      menu: (context) => MenuScreen(),


    };
  }
}
