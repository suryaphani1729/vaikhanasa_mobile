import 'package:flutter/material.dart';
import 'package:noname_flutter/views/routes/navigation_provider.dart';
import 'package:noname_flutter/views/routes/pageroutes.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class NavigationDrawer extends StatelessWidget {
  //late NavigationProvider navigator;
  late User user;

  @override
  Widget build(BuildContext context) {
    // navigator = Provider.of<NavigationProvider>(context);
    user = Provider.of<User>(context, listen: true);
    return Consumer<NavigationProvider>(
      builder: (context, navigator, child) => Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Text('${user.name.toString()}!'),
              decoration: const BoxDecoration(color: Colors.orangeAccent)),
          ListTile(
            title: const Text('Home'),
            selected: navigator.rounterName == PageRoutes.home,
            selectedTileColor: Colors.grey.shade300,
            onTap: () {
              if (navigator.rounterName != PageRoutes.home) {
                navigator.setRouterName(PageRoutes.home);
                Navigator.pushReplacementNamed(context, PageRoutes.home);
              }
            },
          ),
          ListTile(
              title: const Text('Profile'),
              selected: navigator.rounterName == PageRoutes.profile,
              selectedTileColor: Colors.grey.shade300,
              onTap: () {
                if (navigator.rounterName != PageRoutes.profile) {
                  navigator.setRouterName(PageRoutes.profile);
                  Navigator.pushReplacementNamed(context, PageRoutes.profile);
                }
              }),
          ListTile(
              title: const Text('Users'),
              selected: navigator.rounterName == PageRoutes.usersList,
              selectedTileColor: Colors.grey.shade300,
              onTap: () {
                if (navigator.rounterName != PageRoutes.usersList) {
                  navigator.setRouterName(PageRoutes.usersList);
                  Navigator.pushReplacementNamed(context, PageRoutes.usersList);
                }
              }),
          ListTile(
              title: const Text('Accomodation'),
              selected: navigator.rounterName == PageRoutes.accommodation,
              selectedTileColor: Colors.grey.shade300,
              onTap: () {
                if (navigator.rounterName != PageRoutes.accommodation) {
                  navigator.setRouterName(PageRoutes.accommodation);
                  Navigator.pushReplacementNamed(
                      context, PageRoutes.accommodation);
                }
              }),
          ListTile(
              title: const Text('Magazine'),
              selected: navigator.rounterName == PageRoutes.magazine,
              selectedTileColor: Colors.grey.shade300,
              onTap: () {
                if (navigator.rounterName != PageRoutes.magazine) {
                  navigator.setRouterName(PageRoutes.magazine);
                  Navigator.pushReplacementNamed(context, PageRoutes.magazine);
                }
              }),
        ],
      )),
    );
  }
}
