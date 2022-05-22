import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/product_provider.dart';
import '../product_screeen/product_screen.dart';
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
    ProductScreen(),
    Center(child: Text('Orders')),
  ];
  @override
  Widget build(BuildContext context) {
    final int currentIndex = Provider.of<AppProvider>(context).currentTap;
    Provider.of<CategoryProvider>(context).init();
    Provider.of<ProductProvider>(context).init();
    return Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: const MainBottomNavigationBar());
  }
}
