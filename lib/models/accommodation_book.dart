import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccommodationBook extends ChangeNotifier {
  int? noOfSingleRooms;
  int? noOfDoubleRooms;
  int? noOfDays;

  int? noOfPersons;
  String? fromDate;
  String? toDate;
  String? idProofName;
  String? idProofNumber;
  int? male;
  int? female;
  int? other;
  int? child;

  AccommodationBook(
      {this.noOfSingleRooms,
      this.noOfDoubleRooms,
      this.noOfDays,
      this.noOfPersons,
      this.fromDate,
      this.toDate,
      this.idProofName,
      this.idProofNumber,
      this.male,
      this.female,
      this.other,
      this.child});

  factory AccommodationBook.fromJson(Map<String, dynamic> json) {
    return AccommodationBook(
        noOfSingleRooms: json['noOfSingleRooms'] as int?,
        noOfDoubleRooms: json['noOfDoubleRooms'] as int?,
        noOfDays: json['noOfDays'] as int?,
        noOfPersons: json['noOfPersons'] as int?,
        fromDate: json['fromDate'] as String?,
        toDate: json['toDate'] as String?,
        idProofName: json['idProofName'] as String?,
        idProofNumber: json['idProofNumber'] as String?,
        male: json['male'] as int?,
        female: json['female'] as int?,
        other: json['other'] as int?,
        child: json['child'] as int?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'noOfSingleRooms': noOfSingleRooms,
      'noOfDoubleRooms': noOfDoubleRooms,
      'noOfDays': noOfDays,
      'noOfPersons': noOfPersons,
      'fromDate': fromDate,
      'toDate': toDate,
      'idProofName': idProofName,
      'idProofNumber': idProofNumber,
      'male': male,
      'female': female,
      'other': other,
      'child': child,
    };
  }

  updateAccommodation(
      int noOfSingleRooms,
      int noOfDoubleRooms,
      int noOfDays,
      int noOfPersons,
      String fromDate,
      String toDate,
      String idProofName,
      String idProofNumber,
      int male,
      int female,
      int other,
      int child) {
    noOfSingleRooms = noOfSingleRooms;
    noOfDoubleRooms = noOfDoubleRooms;
    noOfDays = noOfDays;

    noOfPersons = noOfPersons;
    fromDate = fromDate;
    toDate = toDate;
    idProofName = idProofName;
    idProofNumber = idProofNumber;

    male = male;
    female = female;
    other = other;
    child = child;
    print("Accommodation Book*********************");
    notifyListeners();
  }
}
