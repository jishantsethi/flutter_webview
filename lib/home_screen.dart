import 'package:SwooBrothers/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_bottom_navigation.dart';
import 'bottom_screens/first_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String url = "https://swoobrothers.store/";
  // Define a GlobalKey to access the WebViewScreenState
  final GlobalKey<WebViewState> webViewKey = GlobalKey<WebViewState>();

  // Define a map of GlobalKeys for each tab index
  final Map<int, GlobalKey<WebViewState>> webViewKeys = {
    0: GlobalKey<WebViewState>(),
    1: GlobalKey<WebViewState>(),
    2: GlobalKey<WebViewState>(),
    3: GlobalKey<WebViewState>(),
  };


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
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            // Find the WebViewScreen state
           // final webViewScreenState = webViewKey.currentState;
            // Access the WebView's GlobalKey for the current tab
            final item = Provider.of<BottomNavigatorProvider>(context, listen: false);
            final webViewScreenState = webViewKeys[item.selectedIndex]?.currentState;
            // Access the WebViewScreen's state using the GlobalKey
            print("webViewScreenState is ${webViewScreenState}");
            if (webViewScreenState != null) {
              // Call the back navigation logic
              bool handled = await webViewScreenState.handleBackNavigation();
              print("webViewScreenState  handled is ${handled}");
              if (!handled) {
                SystemNavigator.pop(); // Exit the screen if WebView cannot go back
              }
            } else {
              SystemNavigator.pop(); // Default behavior
            }
          },
        ),
      ),
      body: Center(
        child: Padding(
          //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding: EdgeInsets.only(top: 0),
          child: Consumer<BottomNavigatorProvider>(
              builder: (ctx, item, child) {
                return  WebView(
                  key: webViewKeys[item.selectedIndex], // Unique key to rebuild on tab change.
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

class BackButtonHandler extends StatelessWidget {
  final Widget child;
  const BackButtonHandler({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final navigator = Navigator.of(context);
        if (navigator.canPop()) {
          navigator.pop();
          return false;
        }
        return true;
      },
      child: child,
    );
  }
}
