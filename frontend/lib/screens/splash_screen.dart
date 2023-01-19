import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tweet_feed/screens/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(
              'assets/splash/programming_comp.json',
              onLoaded: (composition){
                Future.delayed(const Duration(seconds: 0.15), (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Wrapper()));
                });
              }
            ),
            const SizedBox(height: 20,),
            const Text('Git Synchronous',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                )
            ),
            ///Future.delayed(
            //           const Duration(milliseconds: 2), () =>
            //           Navigator.pushReplacement(
            //             context, MaterialPageRoute(
            //               builder: (context) => const Wrapper()
            //           ))
            //         );
          ],
        ),
      )
    );
  }
}
