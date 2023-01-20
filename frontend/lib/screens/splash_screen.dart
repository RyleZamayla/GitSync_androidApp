import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tweet_feed/screens/wrapper.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomSplashScreen> createState() => _ScreenState();
}

class _ScreenState extends State<CustomSplashScreen> with TickerProviderStateMixin{
  late AnimationController splashController;
  bool splashLoad = false;
  bool showLabel = false;

  @override
  void initState() {
    super.initState();
    splashController = AnimationController(vsync: this);
    splashController.addListener(() {
      if (splashController.value > 0.7) {
        splashController.stop();
        setState(() => splashLoad = true);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Wrapper()));
        });
      }
    });
  }
  @override
  void dispose() {
    splashController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
              visible: !splashLoad,
              child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: (const Duration(seconds: 1)),
                  child: Column(
                    children: [
                      Lottie.asset('assets/splash/mobile_dev.json',
                        controller: splashController,
                        onLoaded: (animation){
                          splashController..duration = animation.duration..forward();
                        },
                      ),
                      Center(
                        child: AnimatedOpacity(
                          opacity: !splashLoad? 1.0 : 0.0,
                          duration: const Duration(seconds: 1),
                          child: const Text(
                              'Git-Sync',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                color: CupertinoColors.activeBlue,
                                fontSize: 20,
                              )
                          ),
                        ),
                      )
                    ],
                  )
              )
          ),
          Center(
            child: AnimatedOpacity(
              opacity: splashLoad? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: const Text(
                  'Git-Sync',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: CupertinoColors.activeBlue,
                    fontSize: 20,
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
