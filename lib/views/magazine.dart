import 'package:flutter/material.dart';

import 'routes/navigation_drawer.dart';

class MagazinePage extends StatelessWidget {
  static const String routeName = '/magazine';
  const MagazinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(title: const Text('Magazine')),
      body: Container(child: Text('Magazine Page')),
    );
  }
}
