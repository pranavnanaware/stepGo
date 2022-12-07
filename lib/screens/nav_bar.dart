import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step/color_schemes.dart';
import 'package:step/screens/bazaar.dart';
import 'package:step/screens/home_screen.dart';
import 'package:step/screens/profile_screen.dart';

class NavigationScreen extends StatefulHookConsumerWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  int selectedIndex = 0;
  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> children = [
    const HomeScreen(),
    const BaazarPage(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: children[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
              ),
              label: "Bazaar"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: tertiaryColor,
        onTap: onItemTapped,
      ),
    );
  }
}
