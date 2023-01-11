import 'package:flutter/material.dart';
import 'package:tweet_feed/screens/home/feed.dart';
import 'package:tweet_feed/screens/home/search.dart';
import 'package:tweet_feed/services/auth.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Authentication _authService = Authentication();
  int _currentIndex = 0;
  final List <Widget> _children = [
    Feed(),
    Search()
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
          title: const Text("home")
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, '/add');
          },
          child: const Icon(Icons.add)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                    color: Colors.blue)
            ),
            ListTile(
              title: Text('Profile'),
              onTap: (){
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
                title: Text('Logout'),
                onTap: () async {
                  await _authService.logout();
                }
            )
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onPressedTab,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search')
        ],
      ),
    );
  }
}


