import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String email = '', password = '';
  bool isLoading = false;
  int charCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
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
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Lottie.asset(
                'assets/splash/programming_comp.json',
                width: 200, height: 200,
              ),
              const Text(
                  'Enter your email to receive\nlink for reset-password',
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: CupertinoColors.systemGrey2,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(height: 10,),
              TextFormField(
                style: const TextStyle(color: CupertinoColors.systemGrey2),
                maxLength: 50,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: isLoading ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(color: CupertinoColors.white,),
                    ),
                    SizedBox(width: 20,),
                    Text('Please wait...')
                  ],
                ) : const Text("Send request", style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),),
                onPressed: () async => {
                  if(email.isNotEmpty){
                    setState(() => isLoading = true),
                    Future.delayed(const Duration(seconds: 3),() => setState(() {
                      isLoading = false;
                      Flushbar(
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        message: "Request link is sent to your email",
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        duration: const Duration(seconds: 3),
                        leftBarIndicatorColor: CupertinoColors.activeBlue,
                        icon: const Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: CupertinoColors.activeBlue,
                        ),
                      ).show(context);
                    })),
                    auth.sendPasswordResetEmail(email: email),
                  } else {
                    setState(() => isLoading = true),
                    await Future.delayed(const Duration(seconds: 2),() => setState(() {
                      isLoading = false;
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        message: "Please enter your email.",
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
                  }
                },
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
