import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinyhood/pages/bottom_page_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCurrentUser();
    });
    super.initState();
  }

  void checkCurrentUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomRouter()),
      );
    }
  }

  void googleLogin(BuildContext context) async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $result");
      print(result.displayName);
      print(result.email);
      print(result.photoUrl);

      // Add a document with the Gmail ID as the document ID in Firestore
      await FirebaseFirestore.instance
          .collection("userdata")
          .doc(result.email)
          .set({"name": ""});

      if (finalResult.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomRouter()),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  // Future<void> logout() async {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (!Navigator.canPop(context)) {
            return true; // allow system back button
          } else {
            return false; // do nothing
          }
        },
        child: Scaffold(
          // actions: [
          //   TextButton(
          //     onPressed: logout,
          //     child: const Text(
          //       'LogOut',
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   )
          // ],

          body: SafeArea(
            child: Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "The Best for\nyour Newborn",
                        style: TextStyle(
                            fontFamily: "Lexend",
                            fontSize: 30,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(width: 20.0, height: 100.0),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Lexend',
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('EMPOWERED',
                                  duration: const Duration(milliseconds: 1000),
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer)),
                              RotateAnimatedText('ORGANIZED',
                                  duration: const Duration(milliseconds: 1000),
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer)),
                              RotateAnimatedText('HEALTHY',
                                  duration: const Duration(milliseconds: 1000),
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        googleLogin(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.login),
                            const Padding(
                              padding: EdgeInsets.only(left: 24, right: 8),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/baby3.png',
                      fit: BoxFit.cover,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
