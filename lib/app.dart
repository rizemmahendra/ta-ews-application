// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ta_ews_application/features/call_center/view/call_center_view.dart';
import 'package:ta_ews_application/features/detail/view/detail_view.dart';
import 'package:ta_ews_application/features/home/view/homa_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> pages = [
    Homepage(),
    DetailPage(),
    CallCenterPage(),
    CallCenterPage()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF545454),
      appBar: AppBar(
        // backgroundColor: Colors.amber[800],
        title: const Text('Peringatan Dini Banjir Bandang'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      bottomNavigationBar: NavigationBar(
          // backgroundColor: Colors.amber[800],
          indicatorColor: Colors.white,
          selectedIndex: _currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.list),
                selectedIcon: Icon(Icons.list_alt_outlined),
                label: 'Detail'),
            NavigationDestination(
                icon: Icon(Icons.call_outlined),
                selectedIcon: Icon(Icons.call),
                label: 'Call Center'),
            NavigationDestination(
                icon: Icon(Icons.info_outline),
                selectedIcon: Icon(Icons.info),
                label: 'About'),
          ]),
      body: pages.elementAt(_currentIndex),
    );
  }
}
