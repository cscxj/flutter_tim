import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/home_page.dart';
import 'package:flutter_tim/pages/user_info_page.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (_) => HomePage(),
        'user_info_page': (_) => UserInfoPage(),
      },
    ));



