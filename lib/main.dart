import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/home_page.dart';
import 'package:flutter_tim/pages/login_page.dart';
import 'package:flutter_tim/pages/user_info_page.dart';

void main() => runApp(MaterialApp(
      home: LoginPage(),
      routes: {
        //'/': (_) => HomePage(),
        'user_info_page': (_) => UserInfoPage(),
      },
    ));