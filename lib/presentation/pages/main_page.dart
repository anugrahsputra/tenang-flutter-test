import 'package:alesha/presentation/pages/appointment_page.dart';
import 'package:alesha/presentation/pages/home_page.dart';
import 'package:alesha/presentation/pages/inbox_page.dart';
import 'package:alesha/presentation/pages/profile_page.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/mainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _listWidget = [
    Homepage(),
    const AppointmentPage(),
    const InboxPage(),
    const ProfilePage(),
  ];

  final List<BottomNavyBarItem> _navyBarItems = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      activeColor: Colors.blue,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.calendar_month_rounded),
      title: const Text('Appointment'),
      activeColor: Colors.blue,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.inbox_rounded),
      title: const Text('Inbox'),
      activeColor: Colors.blue,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text('Profile'),
      activeColor: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: _navyBarItems,
        ),
      ),
    );
  }
}
