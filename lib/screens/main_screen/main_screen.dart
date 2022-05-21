import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../home_screen/home_screen.dart';
import 'main_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScrenn';
  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    Center(child: Text('Bet')),
    Center(child: Text('Add')),
    Center(child: Text('Message')),
    Center(child: Text('MyProd')),
  ];
  @override
  Widget build(BuildContext context) {
    final int currentIndex = Provider.of<AppProvider>(context).currentTap;
    return Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: const MainBottomNavigationBar());
  }
}
