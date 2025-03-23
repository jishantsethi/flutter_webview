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
    tabItem('About', Icons.category),
    tabItem('Contact', Icons.favorite),
  ];

  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFF000000, color);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: Consumer<BottomNavigatorProvider>(
          builder: (ctx, item, child) {
            return FirstView(
              key: ValueKey(item.selectedIndex), // Unique key to rebuild on tab change.
              url: item.url,
            );
          },
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
