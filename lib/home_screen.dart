import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_bottom_navigation.dart';
import 'bottom_screens/first_view.dart';
import 'bottom_screens/fourth_view.dart';
import 'bottom_screens/second_view.dart';
import 'bottom_screens/third_view.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String url = "https://storktic.com/";

  Map<int, Color> color = {
    50: const Color.fromRGBO(0, 0, 0, .1),
    100: const Color.fromRGBO(0, 0, 0, .2),
    200: const Color.fromRGBO(0, 0, 0, .3),
    300: const Color.fromRGBO(0, 0, 0, .4),
    400: const Color.fromRGBO(0, 0, 0, .5),
    500: const Color.fromRGBO(0, 0, 0, .6),
    600: const Color.fromRGBO(0, 0, 0, .7),
    700: const Color.fromRGBO(0, 0, 0, .8),
    800: const Color.fromRGBO(0, 0, 0, .9),
    900: const Color.fromRGBO(0, 0, 0, 1),
  };

  final arrBottomItems = [
    tabItem('Home', Icons.home),
    tabItem('Shop', Icons.shop),
    tabItem('Cart', Icons.shopping_cart),
    tabItem('My Account', Icons.account_box),
  ];

  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFF000000, color);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Set status bar color to black
        statusBarIconBrightness: Brightness.light, // Set icons to be light
        systemNavigationBarColor: Colors.black, // Set navigation bar color to black
        systemNavigationBarIconBrightness: Brightness.light, // Set navigation bar icons to be light
      ),
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Center(
          child: Consumer<BottomNavigatorProvider>(
            builder: (ctx, item, child) {
              return FirstView(
                key: ValueKey(item.selectedIndex), // Unique key to rebuild on tab change.
                url: item.url,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        arrBottomItems: arrBottomItems,
        backgroundColor: colorCustom,
        showSelectedLables: true,
        showUnselectedLables: true,
        color: Colors.grey,
        selectedColor: Colors.white,
      ),
    );
  }
}
