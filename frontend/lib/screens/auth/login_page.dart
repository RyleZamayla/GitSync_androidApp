import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweet_feed/screens/auth/register_page.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:tweet_feed/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _SignInState();
}

class _SignInState extends State<LoginPage> {

  final Authentication _authService = Authentication();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  String email = '', password = '';
  late bool _password;

  final FocusNode _emailfocusNode = FocusNode();
  final FocusNode _passwordfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _password = false;
    _emailfocusNode.addListener(_onFocusChange);
    _passwordfocusNode.addListener(_onFocusChange);
    email = _emailController.text;
    password = _passwordController.text;
  }
  void _onFocusChange() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(top: 90, right: 20, left: 20),
          child: Center(
            child: ListView(
              children: [
                Lottie.asset('assets/splash/mobile_dev.json', width: 170, height: 170),
                const SizedBox(height: 35),
                const Text('Git sync to everyone in the branch.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    )
                ),
                const SizedBox(height: 35,),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailfocusNode,
                  style: const TextStyle(color: CupertinoColors.systemGrey2),
                  decoration: InputDecoration(
                    suffixIcon: _emailfocusNode.hasFocus ? IconButton(icon: const Icon(Icons.clear_outlined),
                      onPressed: (){
                        setState(() {
                          _emailController.clear();
                        });
                      },) : null,
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
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
                  controller: _passwordController,
                  focusNode: _passwordfocusNode,
                  obscureText: !_password,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: CupertinoColors.systemGrey2),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
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
                      suffixIcon: _passwordfocusNode.hasFocus ? IconButton(
                        icon: Icon(_password ? Icons.visibility : Icons.visibility_off, color: CupertinoColors.systemGrey, size: 20,),
                        onPressed: () {
                          setState(() {
                            _password = !_password;
                          });
                        },
                      ) : null
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
                      FocusScope.of(context).requestFocus(FocusNode()),
                      if(email.isNotEmpty || password.isNotEmpty){
                        _authService.login(email, password),
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green.withOpacity(0.5),
                            content: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const <Widget>[
                                    Icon(Icons.info_outline_rounded, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text('Login Successful.', style: TextStyle(color: Colors.white),)
                                  ]
                              ),
                            ), behavior: SnackBarBehavior.floating,
                          ),
                        ),
                        Future.delayed(const Duration(seconds: 5),(){}),
                      },


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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
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

