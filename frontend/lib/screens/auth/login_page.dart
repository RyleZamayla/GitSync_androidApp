import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:tweet_feed/services/auth.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _SignInState();
}

class _SignInState extends State<LoginPage> {
  final Authentication _authService = Authentication();
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(125, 125, 125, 1.0),
      body: Form(
        child: Center(
          child: Container(
            height: 400,
            width: 470,
            margin: const EdgeInsets.all(20),
            child: Card(
              color: const Color.fromRGBO(61, 59, 59, 1.0),
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text('Sign in to Clone', style: TextStyle(color: Colors.blue, fontSize: 27, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: CupertinoColors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                    onChanged: (val) => setState(() {
                      email = val;
                    }),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: CupertinoColors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                    onChanged: (val) => setState(() {
                      password = val;
                    }),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      )
                    ),
                    onPressed: () async => {
                      _authService.login(email, password)
                    },
                    child: const Text("Login")
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(35),
                      )
                    ),
                    onPressed: () async => {
                      _authService.login(email, password)
                    },
                    child: const Text("Forgot password?", style: TextStyle(color: CupertinoColors.white),)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don''t have an account?',
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        children: <TextSpan> [
                          TextSpan(
                            text: ' Signup',
                            style: const TextStyle(color: CupertinoColors.systemBlue, fontSize: 13),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              /// wla pko kabalo kaau sa routing format so printing sa ta ani nga part
                              debugPrint('SignUp module is not yet created!');
                            }
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: WaveWidget( //user Stack() widget to overlap content and waves
          config: CustomConfig(
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.blue.withOpacity(0.3),
              Colors.blue.withOpacity(0.3),
              //the more colors here, the more wave will be
            ],
            durations: [4000, 5000, 7000],
            //durations of animations for each colors,
            // make numbers equal to numbers of colors
            heightPercentages: [0.01, 0.05, 0.03],
            //height percentage for each colors.
            blur: const MaskFilter.blur(BlurStyle.solid, 5),
            //blur intensity for waves
          ),
          waveAmplitude: 17.00, //depth of curves
          waveFrequency: 3, //number of curves in waves
          ///backgroundColor: Colors.white, //background colors
          size: const Size(
            double.infinity,
            double.infinity,
          ),
        ),
      ),
    );
  }
}
