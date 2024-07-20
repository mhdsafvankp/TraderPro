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
        primarySwatch: Colors.blue,
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
          backgroundColor: Colors.blue,
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
