import 'package:flutter/material.dart';
import 'package:noname_flutter/models/accommodation.dart';
import 'package:noname_flutter/models/accommodation_availability.dart';
import 'package:noname_flutter/models/accommodation_book.dart';
import 'package:noname_flutter/services/accommodation_services.dart';

import 'routes/navigation_drawer.dart';

class AccommodationPage extends StatefulWidget {
  static const String routeName = '/accommodation';
  const AccommodationPage({Key? key}) : super(key: key);

  @override
  State<AccommodationPage> createState() => _AccommodationPageState();
}

class _AccommodationPageState extends State<AccommodationPage> {
  DateTime selectedDate = DateTime.now();
  int noOfSingleRooms = 0;
  int noOfDoubleRooms = 0;
  int noOfDays = 0;
  int noOfMale = 0;
  int noOfFemale = 0;
  int noOfOther = 0;
  int noOfChildren = 0;

  AccommodationService accommodationService = AccommodationService();
  AccommodationAvailability? accommodationAvailability;
  @override
  void initState() {
    super.initState();
    getAccommodationByMonth();
    getAccommodationByDate();
  }

  getAccommodationByDate() async {
    AccommodationAvailability? availabilityResponse = await accommodationService
        .getAvailabilityByDate(DateTime.now().toString());

    setState(() {
      accommodationAvailability = availabilityResponse;
    });
  }

  getAccommodationByMonth() async {
    Accommodation? accommodationByMonth =
        await accommodationService.getAvailabilityByMonth();
    if (accommodationByMonth != null) {
      print(accommodationByMonth.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(title: const Text('Accommodation')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                onDateChanged: (DateTime dateTime) async {
                  setState(() {
                    selectedDate = dateTime;
                  });
                  AccommodationAvailability? availabilityResponse =
                      await accommodationService
                          .getAvailabilityByDate(dateTime.toString());
                  print("-----");
                  print(availabilityResponse!.toJson());
                  setState(() {
                    accommodationAvailability = availabilityResponse;
                  });
                },
                selectableDayPredicate: (DateTime dateTime) {
                  return dateTime.month == DateTime.now().month;
                }),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: Text(
                  'Availability Of Rooms for Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
              trailing: Text(
                  'Single(${accommodationAvailability?.singleRooms}), Double(${accommodationAvailability?.doubleRooms})'),
            ),
            ListTile(
              leading: const Text('No Of Single Rooms'),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (noOfSingleRooms > 0) {
                            setState(() {
                              noOfSingleRooms--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(noOfSingleRooms.toString()),
                    IconButton(
                        onPressed: () {
                          print(noOfSingleRooms);
                          print(accommodationAvailability?.singleRooms);
                          print(noOfSingleRooms !=
                              accommodationAvailability?.singleRooms);
                          if (noOfSingleRooms !=
                              accommodationAvailability?.singleRooms) {
                            setState(() {
                              noOfSingleRooms++;
                            });
                          }
                        },
                        icon: const Icon(Icons.add))
                  ]),
            ),
            ListTile(
              leading: const Text('No Of Double Rooms'),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (noOfDoubleRooms > 0) {
                            setState(() {
                              noOfDoubleRooms--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(noOfDoubleRooms.toString()),
                    IconButton(
                        onPressed: () {
                          if (noOfDoubleRooms !=
                              accommodationAvailability?.doubleRooms) {
                            setState(() {
                              noOfDoubleRooms++;
                            });
                          }
                        },
                        icon: const Icon(Icons.add))
                  ]),
            ),
            ListTile(
              leading: const Text('No Of Days'),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (noOfDays > 0) {
                            setState(() {
                              noOfDays--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(noOfDays.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            noOfDays++;
                          });
                        },
                        icon: const Icon(Icons.add))
                  ]),
            ),
            ListTile(
              leading: const Text('No Of Male'),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (noOfMale > 0) {
                            setState(() {
                              noOfMale--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(noOfMale.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            noOfMale++;
                          });
                        },
                        icon: const Icon(Icons.add))
                  ]),
            ),
            ListTile(
              leading: const Text('No Of Female'),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (noOfFemale > 0) {
                            setState(() {
                              noOfFemale--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(noOfFemale.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            noOfFemale++;
                          });
                        },
                        icon: const Icon(Icons.add))
                  ]),
            ),
            ListTile(
              leading: const Text('No Of Children'),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (noOfChildren > 0) {
                            setState(() {
                              noOfChildren--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(noOfChildren.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            noOfChildren++;
                          });
                        },
                        icon: const Icon(Icons.add))
                  ]),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
                onPressed: () async {
                  AccommodationBook accommodationBook = AccommodationBook(
                      noOfSingleRooms: noOfSingleRooms,
                      noOfDoubleRooms: noOfDoubleRooms,
                      noOfDays: noOfDays,
                      noOfPersons:
                          noOfMale + noOfFemale + noOfOther + noOfChildren,
                      fromDate: selectedDate.toString(),
                      toDate:
                          selectedDate.add(Duration(days: noOfDays)).toString(),
                      idProofName: 'Aadhar',
                      idProofNumber: 'TempNumber',
                      male: noOfMale,
                      female: noOfFemale,
                      child: noOfChildren,
                      other: noOfOther);
                  var response = await accommodationService
                      .bookAccommodation(accommodationBook);
                  setState(() {
                    noOfSingleRooms = 0;
                    noOfDoubleRooms = 0;
                    noOfDays = 0;
                    noOfMale = 0;
                    noOfFemale = 0;
                    noOfOther = 0;
                    noOfChildren = 0;
                  });
                },
                child: Text('Submit')),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
