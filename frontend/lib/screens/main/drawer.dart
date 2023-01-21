import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tweet_feed/screens/main/about_us.dart';
import 'package:tweet_feed/services/auth.dart';
import 'package:lottie/lottie.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  void navigateToAboutUsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
  }

  final Authentication _authService = Authentication();
  // final UserServices _userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 20, 45, 1.0),
      body: Form(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Lottie.asset('assets/splash/mobile_dev.json',
                    width: 200, height: 120),
                const Text('Git-Sync',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Ubunto',
                      color: Color(0xFFBCAAA4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Expanded(
                  child:Text('Click  Post  React  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Ubunto',
                        color: Color(0xFFD7CCC8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(top: 22),
                  leading: const Icon(
                    Icons.person,
                    size: 25,
                    color: Color(0xFFE0E0E0
                    ),
                  ),
                  title: const Text('Profile',
                    style: TextStyle(
                        color: Color(0xFFE0E0E0),
                        fontFamily: 'Ubunto',
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, '/profile',
                        arguments: FirebaseAuth
                            .instance
                            .currentUser!.uid
                    );
                  },
                ),
                ListTile(
                    contentPadding: const EdgeInsets.only(bottom: 35),
                    leading: const Icon(
                      Icons.logout,
                      size: 25,
                      color: Color(0xFFE0E0E0
                      ),
                    ),
                    title: const Text('Logout',
                      style: TextStyle(
                          color: Color(0xFFE0E0E0),
                          fontFamily: 'Ubunto',
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () async {
                      await _authService.logout();
                    }
                ),
              ListTile(
                contentPadding: const EdgeInsets.only(bottom: 35),
              leading: const Icon(Icons.info,
              size: 25,
              color: Color(0xFFE0E0E0
              ),
              ),
        title: const Text('About Us',
        style: TextStyle(
          color: Color(0xFFE0E0E0),
          fontFamily: 'Ubunto',
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        ),
        onTap: navigateToAboutUsPage,
              ),
              ],
            ),
          )
      ),
    );
  }
}
