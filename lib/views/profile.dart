import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noname_flutter/models/profile.dart';
import 'package:noname_flutter/models/user.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart' as Constants;
import 'routes/navigation_drawer.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  final http.Client? httpClient = http.Client();
  Profile profile = Profile();
  User user = User();

  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile formData = Profile();
  Profile profileData = Profile();
  User userData = User();
  Future<SharedPreferences> sp = SharedPreferences.getInstance();

  String token = '';
  @override
  void initState() {
    loadToken();
  }

  loadToken() async {
    sp.then((value) {
      setState(() {
        token = value.getString('token').toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    profileData = context.watch<Profile>();
    userData = context.read<User>();

    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      drawer: NavigationDrawer(),
      body: Form(
          child: Scrollbar(
              child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('${userData.name}'),
                    subtitle: Text('${userData.category} - ${userData.phone}'),
                  ),
                ],
              ),
            ),
            TextFormField(
              initialValue: profileData.about,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter About',
                labelText: 'About',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                formData.about = value;
              },
            ),
            TextFormField(
              initialValue: profileData.address,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter Address',
                labelText: 'Address',
              ),
              onChanged: (value) {
                formData.address = value;
              },
            ),
            TextFormField(
              initialValue: profileData.profession,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Enter Profession',
                labelText: 'Profession',
              ),
              onChanged: (value) {
                formData.profession = value;
              },
            ),
            TextButton(
                onPressed: () async {
                  try {
                    var result = await http.post(
                        Uri.parse('${Constants.domain}/profiles/'),
                        body: json.encode(formData.toJson()),
                        headers: {
                          'content-type': 'application/json',
                          'x-auth-token': token
                        });
                    context.read<Profile>().updateProfile(
                        formData.about.toString(),
                        formData.address.toString(),
                        formData.profession.toString());
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Save')),
          ],
        ),
      ))),
    );
  }
}
