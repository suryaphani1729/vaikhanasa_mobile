import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User extends ChangeNotifier {
  String? name;
  String? category;
  String? phone;

  User({this.name, this.category, this.phone});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'] as String?,
        category: json['category'] as String?,
        phone: json['phone'] as String?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'phone': phone,
    };
  }

  updateUser(String _name, String _category, String _phone) {
    name = _name;
    category = _category;
    phone = _phone;
    print("User updated*********************");
    notifyListeners();
  }
}
