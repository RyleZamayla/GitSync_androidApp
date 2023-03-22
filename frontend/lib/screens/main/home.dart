import 'package:flutter/material.dart';
import 'package:tweet_feed/screens/home/feed.dart';
import 'package:tweet_feed/screens/home/search.dart';
import 'package:tweet_feed/screens/main/drawer.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final List <Widget> _children = [
    const Feed(),
    const Search()
  ];

  void onPressedTab(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
        title: const Text("News Feed"),
      ),
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff051a2f),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        onTap: onPressedTab,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search')
        ],
      ),
    );
  }
}


