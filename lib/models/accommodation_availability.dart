import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccommodationAvailability extends ChangeNotifier {
  int? singleRooms;
  int? doubleRooms;

  AccommodationAvailability({this.singleRooms, this.doubleRooms});

  factory AccommodationAvailability.fromJson(Map<String, dynamic> json) {
    return AccommodationAvailability(
        singleRooms: json['singleRooms'] as int?,
        doubleRooms: json['doubleRooms'] as int?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'singleRooms': singleRooms,
      'doubleRooms': doubleRooms,
    };
  }

  updateAccommodation(int sRooms, int dRooms) {
    singleRooms = sRooms;
    doubleRooms = dRooms;
    print("Accommodation Availability*********************");
    notifyListeners();
  }
}
