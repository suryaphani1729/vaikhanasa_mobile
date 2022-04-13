import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noname_flutter/views/accommodation.dart';
import 'package:noname_flutter/views/home.dart';
import 'package:noname_flutter/views/login.dart';
import 'package:noname_flutter/views/magazine.dart';
import 'package:noname_flutter/views/profile.dart';
import 'package:noname_flutter/views/routes/navigation_provider.dart';
import 'package:noname_flutter/views/routes/pageroutes.dart';
import 'package:noname_flutter/views/users_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './utils/constants.dart' as Constants;
import 'models/profile.dart';
import 'models/user.dart';

void main() async {
  Future<SharedPreferences> sp = SharedPreferences.getInstance();
  sp.then(
    (_pref) {
      final token = _pref.getString('token');
      if (token == null || token == '') {
        runApp(const NLoggedInUser());
      } else {
        runApp(MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MultiProvider(providers: [
            ChangeNotifierProvider(
              create: (context) => Profile(),
            ),
            ChangeNotifierProvider(
              create: (context) => User(),
            ),
            ChangeNotifierProvider(
              create: (context) => NavigationProvider(),
            )
          ], child: LoggedInUser()),
          debugShowCheckedModeBanner: false,
        ));
      }
    },
  );
}

class LoggedInUser extends StatefulWidget {
  LoggedInUser({Key? key}) : super(key: key);

  @override
  State<LoggedInUser> createState() => _LoggedInUserState();
}

class _LoggedInUserState extends State<LoggedInUser> {
  late User user = User();
  late Profile profile = Profile();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  loadProfile() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    var result = await http.get(Uri.parse('${Constants.domain}/profiles/me'),
        //body: json.encode(formData.toJson()),
        headers: {'content-type': 'application/json', 'x-auth-token': token});
    final profileObject = json.decode(result.body.toString());

    setState(() {
      user = User.fromJson(profileObject['user']);
      profile = Profile.fromJson(profileObject['profile']);
    });

    final _profileData = Profile.fromJson(profileObject['profile']);
    final _userData = User.fromJson(profileObject['user']);
    context.read<Profile>().updateProfile(_profileData.about.toString(),
        _profileData.address!.toString(), _profileData.profession!.toString());
    context.read<User>().updateUser(_userData.name.toString(),
        _userData.category.toString(), _userData.phone.toString());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        PageRoutes.home: (context) => HomePage(),
        PageRoutes.profile: (context) => ProfilePage(),
        PageRoutes.usersList: (context) => UsersListPage(),
        PageRoutes.accommodation: (context) => AccommodationPage(),
        PageRoutes.magazine: (context) => MagazinePage(),
      },
    );
  }
}

class NLoggedInUser extends StatelessWidget {
  const NLoggedInUser({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
