import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Placeholder Screens
  static const List<Widget> _screens = <Widget>[
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Standard Modern Nav Bar')),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home), // Filled icon for active state
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed, // Essential for 4+ items
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple, // Accent color
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        onTap: _onItemTapped,
        elevation: 10, // Gives a nice subtle shadow
      ),
    );
  }
}
