import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart' as Constants;

@JsonSerializable()
class FormData {
  String? name;
  String? category;
  String? phone;
  String? password;
  FormData({this.name, this.category, this.phone, this.password});

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      name: json['name'] as String?,
      category: json['category'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'phone': phone,
      'password': password,
    };
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FormData formData = FormData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
                hintText: 'Enter Your Name',
                labelText: 'Name',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                formData.name = value;
              },
            ),
            DropdownButton(
                value: formData.category,
                items: <String>["Category1", "Category2", "Category3"]
                    .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ))
                    .toList(),
                onChanged: (String? value) {
                  formData.category = value;
                }),
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
                        Uri.parse('${Constants.domain}/users/'),
                        body: json.encode(formData.toJson()),
                        headers: {'content-type': 'application/json'});

                    print(result);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Submit'))
          ],
        ),
      ))),
    );
  }
}
