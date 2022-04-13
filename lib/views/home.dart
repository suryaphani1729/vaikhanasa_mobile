import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noname_flutter/models/profile.dart';
import 'package:noname_flutter/views/login.dart';
import 'package:noname_flutter/views/profile.dart';
import 'package:noname_flutter/views/routes/navigation_drawer.dart';
import 'package:noname_flutter/views/routes/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(title: const Text('Home'), actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                final sp = await SharedPreferences.getInstance();
                sp.remove('token');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  ModalRoute.withName('/'),
                );
              },
              child: const Icon(
                Icons.logout,
                size: 26.0,
              ),
            )),
      ]),
      body: Container(child: Text('Home Page')),
    );
  }
}
