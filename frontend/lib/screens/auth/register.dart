import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tweet_feed/screens/wrapper.dart';
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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  late bool _password, _passwordConfirm;
  String email = '', password = '', passwordConfirm = '';
  bool isSubmit = false, isPressed = false;
  int charCount = 0;

  @override
  void initState() {
    super.initState();
    _password = false;
    _passwordConfirm = false;
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
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
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment(3.7, 1),
                  colors: <Color>[
                    // Color(0xff1f005c),
                    // Color(0xff5b0060),
                    Color(0xff870160),
                    Color(0xffac255e),
                    // Color(0xffca485c),
                    // Color(0xffe16b5c),
                    // Color(0xfff39060),
                    // Color(0xffffb56b),
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds),
                child: const Icon(
                  CupertinoIcons.person_add_solid,
                  size: 100,
                ),
              ),
              const Center(
                child: Text('Create an account.',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20, fontWeight:
                    FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                style: const TextStyle(color: CupertinoColors.systemGrey2),
                maxLength: 50,
                decoration: InputDecoration(
                  suffixIcon: _emailFocusNode.hasFocus ? IconButton(icon: const Icon(Icons.clear_outlined),
                    onPressed: (){
                      setState(() {
                        _emailController.clear();
                      });
                    },
                  ) : null,
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
                  counterStyle: const TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontSize: 12,
                  ),
                  counterText: null,
                ),
                onChanged: (val) => setState(() {
                  charCount = charCount + 1;
                  email = val;
                }),
              ),
              TextFormField(
                obscureText: !_password,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(color: CupertinoColors.systemGrey2),
                decoration: InputDecoration(
                  suffixIcon: _passwordFocusNode.hasFocus ? IconButton(
                    icon: Icon(_password ? Icons.visibility : Icons.visibility_off, color: CupertinoColors.systemGrey, size: 20,),
                    onPressed: (){
                      setState(() {
                        _password = !_password;
                      });
                    },
                  ) : null,
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
                ),
                onChanged: (val) => setState(() {
                  password = val;
                }),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                obscureText: !_passwordConfirm,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(color: CupertinoColors.systemGrey2),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey,),
                  labelText: 'Confirm password',
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
                  suffixIcon: _passwordFocusNode.hasFocus ? IconButton(
                    icon: Icon(_passwordConfirm ? Icons.visibility : Icons.visibility_off, color: CupertinoColors.systemGrey, size: 20,),
                    onPressed: (){
                      setState(() {
                        _passwordConfirm = !_passwordConfirm;
                      });
                    },
                  ) : null,
                ),
                onChanged: (val) => setState(() {
                  passwordConfirm = val;
                }),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                onPressed: () async =>{
                  if(email.isNotEmpty && password.isNotEmpty){
                    if(password == passwordConfirm){
                      _authService.register( email, password),
                      setState(() => isSubmit = true),
                      Future.delayed(const Duration(seconds: 4),() => setState(() {
                        isSubmit = false;
                        Flushbar(
                          flushbarPosition: FlushbarPosition.TOP,
                          title: 'Hey Developer!',
                          message: "Welcome to synchronous branch.",
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          duration: const Duration(seconds: 3),
                          leftBarIndicatorColor: CupertinoColors.activeBlue,
                          icon: const Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: CupertinoColors.activeBlue,
                          ),
                        ).show(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Wrapper()));
                      })),
                    } else{
                      setState(() => isSubmit = true),
                      Future.delayed(const Duration(seconds: 2),() => setState(() {
                        isSubmit = false;
                        Flushbar(
                          flushbarPosition: FlushbarPosition.TOP,
                          message: "Password does not match.",
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          duration: const Duration(seconds: 3),
                          leftBarIndicatorColor: CupertinoColors.activeOrange,
                          icon: const Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: CupertinoColors.activeOrange,
                          ),
                        ).show(context);
                      })),
                    }
                  } else {
                    setState(() => isSubmit = true),
                    await Future.delayed(const Duration(seconds: 3),() => setState(() {
                      isSubmit = false;
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        message: "Missing required field",
                        margin: const EdgeInsets.all(10),
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        duration: const Duration(seconds: 2),
                        leftBarIndicatorColor: CupertinoColors.activeOrange,
                        icon: const Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: CupertinoColors.activeOrange,
                        ),
                      ).show(context);
                    })),
                  },
                },
                child: isSubmit ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(color: CupertinoColors.white,),
                    ),
                    SizedBox(width: 20,),
                    Text('Creating account...')
                  ],
                ) : const Text("Register", style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),),
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
                        style: const TextStyle(color: CupertinoColors.activeBlue, fontSize: 13),
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
