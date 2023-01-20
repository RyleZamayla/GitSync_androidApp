import 'package:flutter/material.dart';
import 'package:tweet_feed/screens/home/feed.dart';
import 'package:tweet_feed/screens/home/search.dart';
import 'package:tweet_feed/screens/main/drawer.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);


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
        title: const Text("home"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/add');
          },
          child: const Icon(Icons.add)),
      drawer: const Drawer(
        child: DrawerPage(

        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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


