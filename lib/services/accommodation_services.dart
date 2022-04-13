import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:noname_flutter/models/accommodation.dart';
import 'package:noname_flutter/models/accommodation_availability.dart';
import 'package:noname_flutter/models/accommodation_book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart' as Constants;

class AccommodationService {
  Future<Accommodation?> getAvailabilityByMonth() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token') ?? '';
    if (token != '') {
      var result = await http.post(
          Uri.parse('${Constants.domain}/accommodation/getAvailabilityByMonth'),
          body: json.encode({'byDate': '2022-04-07'}),
          headers: {'content-type': 'application/json', 'x-auth-token': token});

      return Accommodation.fromJson(json.decode(result.body.toString()));
    } else {
      return null;
    }
  }

  Future<AccommodationAvailability?> getAvailabilityByDate(
      String byDate) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token') ?? '';
    if (token != '') {
      var result = await http.post(
          Uri.parse('${Constants.domain}/accommodation/getAvailabilityByDate'),
          body: json.encode({'byDate': byDate}),
          headers: {'content-type': 'application/json', 'x-auth-token': token});

      return AccommodationAvailability.fromJson(
          json.decode(result.body.toString()));
    } else {
      return null;
    }
  }

  dynamic bookAccommodation(AccommodationBook accommodationBook) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token') ?? '';
    if (token != '') {
      var result = await http.post(
          Uri.parse('${Constants.domain}/accommodation/bookAccommodation'),
          body: json.encode(accommodationBook.toJson()),
          headers: {'content-type': 'application/json', 'x-auth-token': token});

      return result.body.toString();
    } else {
      return null;
    }
  }
}
