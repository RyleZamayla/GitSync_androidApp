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
  late bool _password;
  @override
  void initState() {
    super.initState();
    _password = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(top: 90, right: 20, left: 20),
          child: ListView(
            children: [
              const Text('Git sync to everyone in the branch.', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),),
              const SizedBox(height: 35,),
              TextFormField(
                style: const TextStyle(color: CupertinoColors.systemGrey2),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey,),
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: CupertinoColors.systemGrey2),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: CupertinoColors.activeBlue,)
                  ),
                ),
                onChanged: (val) => setState(() {
                  email = val;
                }),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                obscureText: !_password,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(color: CupertinoColors.systemGrey2),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey,),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: CupertinoColors.systemGrey2),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: CupertinoColors.activeBlue,)
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_password ? Icons.visibility : Icons.visibility_off, color: CupertinoColors.systemGrey, size: 20,),
                    onPressed: () {
                      setState(() {
                        _password = !_password;
                      });
                    },
                  ),
                ),
                onChanged: (val) => setState(() {
                  password = val;
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 200),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: <TextSpan> [
                      TextSpan(
                          text: 'Forgot password?',
                          style: const TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () async{
                            _authService.login(email, password);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () async => {
                    _authService.login(email, password),
                    /**if(email.isNotEmpty || password.isNotEmpty){
                      _authService.login(email, password),
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade900,
                            ),
                            child: const Text('Required field can''t be empty.'),
                          ),
                          behavior: SnackBarBehavior.floating,
                        )
                      )
                    } else {
                      ///dli nko ma trace ang authentication kai wla ko aha na file
                      if (authentication of account is invalid){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                color: Colors.grey.shade900,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('Invalid username and password.'),
                              ),
                            )
                        )
                      }
                    } **/
                  },
                  child: const Text("Login", style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  Expanded(
                    child: Divider(
                      endIndent: 10,
                      indent: 10,
                      thickness: 1,
                      color: CupertinoColors.systemGrey2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'or',
                    style: TextStyle(color: CupertinoColors.systemGrey2),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      endIndent: 10,
                      indent: 10,
                      thickness: 1,
                      color: CupertinoColors.systemGrey2,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    )
                ),
                onPressed: () async => {
                  _authService.login(email, password)
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('assets/images/google_icon96.png'),
                      width: 30,
                    ),
                    SizedBox(width: 10),
                    Text("Continue with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.bold)
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                    text: 'Don''t have an account?',
                    style: const TextStyle(color: CupertinoColors.systemGrey2, fontSize: 13),
                    children: <TextSpan> [
                      TextSpan(
                          text: '    Signup',
                          style: const TextStyle(color: CupertinoColors.systemBlue, fontSize: 13),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            ///RegisterPage();
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 20,
        width: 400,
        child: WaveWidget(
          config: CustomConfig(
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: [0.20, 0.23, 0.25, 0.30],
            blur: const MaskFilter.blur(BlurStyle.outer, 10),

            colors: const [
              Colors.white70,
              Colors.white54,
              Colors.white30,
              Colors.white24,
            ],
          ),
          waveAmplitude: 7.25,
          size: const Size(
            double.infinity,
            double.infinity,
          ),
        ),
      ),
    );
  }
}

