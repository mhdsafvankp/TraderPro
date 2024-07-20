import 'package:flutter/material.dart';
import 'package:trader_pro/utilities/contants.dart';
import 'package:trader_pro/view/screens/pre_trade_screen.dart';
import 'package:trader_pro/view/screens/on_trade_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trader Pro',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xff0642a2,
          <int, Color>{
            50: Color(0x1a0642a2),
            100: Color(0x330642a2),
            200: Color(0x4d0642a2),
            300: Color(0x660642a2),
            400: Color(0x800642a2),
            500: Color(0x990642a2),
            600: Color(0xb30642a2),
            700: Color(0xcc0642a2),
            800: Color(0xe60642a2),
            900: Color(0xff0642a2),
          },
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(traderProHome)),
        body: PageView(
          onPageChanged: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          controller: pageController,
          children: const <Widget>[
            MyHomePage(title: 'Pre Trade'),
            OnTradeScreen(title: 'On Trade',),
            Center(child: Text('post trade screen coming soon')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff0642a2),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              pageController.animateToPage(_selectedIndex,
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_before),
              label: 'Pre Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'On Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigate_next),
              label: 'Post Trade',
            )
          ],
        ),
      ),
    );
  }
}
