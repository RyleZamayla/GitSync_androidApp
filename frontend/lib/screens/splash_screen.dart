import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tweet_feed/screens/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

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
                    _animationController.addStatusListener((status) {
                      if (status == AnimationStatus.completed) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const Wrapper()),
                        );
                      }
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
              FadeTransition(
                opacity: _animation,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
    );
  }
}
