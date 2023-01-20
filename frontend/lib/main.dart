import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/screens/splash_screen.dart';
import 'package:tweet_feed/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return MultiProvider(
            providers: [
              StreamProvider<UserModel?>.value(
                value:Authentication().user,
                initialData: null
              )
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: CustomSplashScreen(),
            )
          );
        }
        return const Text("Loading");
      }
    );
  }
}
