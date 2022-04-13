import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Profile extends ChangeNotifier {
  String? about;
  String? address;
  String? profession;
  Profile({this.about, this.address, this.profession});
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        about: json['about'] as String?,
        address: json['address'] as String?,
        profession: json['profession'] as String?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'about': about,
      'address': address,
      'profession': profession,
    };
  }

  updateProfile(String about2, String address2, String profession2) {
    about = about2;
    address = address2;
    profession = profession2;
    print("Profile updated*********************");
    notifyListeners();
  }
}
