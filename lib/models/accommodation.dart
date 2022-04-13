import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Accommodation extends ChangeNotifier {
  Object? singleRooms;
  Object? doubleRooms;

  Accommodation({this.singleRooms, this.doubleRooms});

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
        singleRooms: json['singleRooms'] as Object?,
        doubleRooms: json['doubleRooms'] as Object?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'singleRooms': singleRooms,
      'doubleRooms': doubleRooms,
    };
  }

  updateAccommodation(Object sRooms, Object dRooms) {
    singleRooms = sRooms;
    doubleRooms = dRooms;
    print("Accommodation*********************");
    notifyListeners();
  }
}
