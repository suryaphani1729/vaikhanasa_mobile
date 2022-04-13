import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart' as Constants;
import '../models/user.dart';
import 'routes/navigation_drawer.dart';
import 'package:http/http.dart' as http;

class UsersListPage extends StatefulWidget {
  static const String routeName = '/usersList';
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<User> usersData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsersList();
  }

  fetchUsersList() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    var result = await http.get(Uri.parse('${Constants.domain}/users/list'),
        //body: json.encode(formData.toJson()),
        headers: {'content-type': 'application/json', 'x-auth-token': token});
    List<dynamic> list = json.decode(result.body.toString());

    setState(() {
      usersData.addAll(list.map((e) => User.fromJson(e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(title: const Text('User List')),
      body: Column(
        children: usersData.map((e) => getUserCard(e)).toList(),
      ),
    );
  }
}

Widget getUserCard(User user) {
  return Card(
    elevation: 5,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('${user.name}'),
          subtitle: Text('${user.category} - ${user.phone}'),
        ),
      ],
    ),
  );
}
