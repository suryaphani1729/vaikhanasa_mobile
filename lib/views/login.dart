import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:noname_flutter/views/home.dart';
import 'package:noname_flutter/views/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart' as Constants;

@JsonSerializable()
class FormData {
  String? phone;
  String? password;
  FormData({this.phone, this.password});

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      phone: json['phone'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
    };
  }
}

class LoginPage extends StatefulWidget {
  final http.Client? httpClient = http.Client();
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FormData formData = FormData();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setTokenInLocal(String token) async {
    await _prefs.then((sp) => sp.setString('token', token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
          child: Scrollbar(
              child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter Phone Number',
                labelText: 'Phone',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                formData.phone = value;
              },
            ),
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (value) {
                formData.password = value;
              },
            ),
            TextButton(
                onPressed: () async {
                  try {
                    var result = await http.post(
                        Uri.parse('${Constants.domain}/auth/'),
                        body: json.encode(formData.toJson()),
                        headers: {'content-type': 'application/json'});
                    final tokenObject = json.decode(result.body.toString());
                    setTokenInLocal(tokenObject['token'].toString());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Submit')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: Text('Register'))
          ],
        ),
      ))),
    );
  }
}
