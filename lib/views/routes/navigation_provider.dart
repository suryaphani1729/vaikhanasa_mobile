import 'package:flutter/foundation.dart';

class NavigationProvider with ChangeNotifier {
  String routerName = '/home';
  String get rounterName => routerName;
  setRouterName(name) {
    routerName = name;
    notifyListeners();
  }
}
