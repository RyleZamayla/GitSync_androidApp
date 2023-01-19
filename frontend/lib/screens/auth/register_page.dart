import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:tweet_feed/services/auth.dart';
import 'package:flutter/gestures.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _SignUpState();
}

class _SignUpState extends State<RegisterPage> {

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: CupertinoColors.white,
          icon: const Icon(CupertinoIcons.xmark),
          iconSize: 27,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(top: 90, right: 20, left: 20),
          child: ListView(
            children: [
              const Text('Create an account.', style: TextStyle(color: CupertinoColors.white, fontSize: 27, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
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
                controller: _passwordController,
                focusNode: _passwordfocusNode,
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
              const SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () async=>{
                    _authService.register(email, password),
                    Navigator.pop(context),
                    /**if (email.isNotEmpty || password.isNotEmpty){
                      _authService.register(email, password),
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Register account successfully.'),
                        ),
                      ),
                    }**/
                    /**if(email.isNotEmpty || password.isNotEmpty){
                        _authService.login(email, password),_authService.register(email, password),
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
                  child: const Text("Register", style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account already?',
                    style: const TextStyle(color: CupertinoColors.systemGrey2, fontSize: 13),
                    children: <TextSpan> [
                      TextSpan(
                        text: '    Sign in',
                        style: const TextStyle(color: CupertinoColors.systemBlue, fontSize: 13),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pop(context);
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
