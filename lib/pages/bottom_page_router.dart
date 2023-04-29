import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tinyhood/pages/bmi_page.dart';
import 'package:tinyhood/pages/settings_page.dart';
import 'package:tinyhood/pages/tips_page.dart';

import 'home_page.dart';

class BottomRouter extends StatefulWidget {
  @override
  State<BottomRouter> createState() => _BottomRouter();
}

class _BottomRouter extends State<BottomRouter> {
  int selectedIndex = 0; // set the initial screen to the home screen

  final List<Widget> screens = [
    HomePage(),
    TipsPage(),
    BmiCalculator(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        haptic: true,
        activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
        selectedIndex: 0,
        gap: 8,
        onTabChange: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.info,
            text: "Tips",
          ),
          GButton(icon: Icons.track_changes, text: "BMI"),
          GButton(
            icon: Icons.person,
            text: "Settings",
          )
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
