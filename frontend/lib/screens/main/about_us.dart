import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweet_feed/screens/main/drawer.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'The Team',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/bracho.png'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Joshua Ryle Bracho ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/naval.png'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Angel Rose Naval',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/moron.png'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Carl Amiel Tristan Moron',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/peña.jpg'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Asareel Don Peña',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/mosqueda..jpg'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Jirah Leil Mosqueda',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/dayata.jpg'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Duke Vincent Paul Dayata',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/profile_pic/dico.png'),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Sandrine Marie Dico',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
