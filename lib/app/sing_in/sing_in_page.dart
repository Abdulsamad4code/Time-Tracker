import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/sing_in/sign_in_button.dart';
import 'package:time_tracker/app/sing_in/sign_in_with_email.dart';
import 'package:time_tracker/app/sing_in/social_sign_in_button.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;
  Future<void> _singInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _singInWithGoogle() async {
    try {
      await auth.singInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _singInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmailSignInPage(auth: auth),
        fullscreenDialog: true
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Time Tracker")),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
              assetsName: "images/google-logo.png",
              text: 'Sign In with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _singInWithGoogle),
          SizedBox(height: 8.0),
          SocialSignInButton(
              assetsName: "images/facebook-logo.png",
              text: 'Sign In with Facebook',
              textColor: Colors.white,
              color: Color(0xff334d92),
              onPressed: _singInWithFacebook),
          SizedBox(height: 8.0),
          SignInButton(
              text: 'Sign In with email',
              textColor: Colors.white,
              color: Colors.teal.shade700,
              onPressed: () => signInWithEmail(context)),
          SizedBox(height: 8.0),
          Text(
            "or",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go Anonymous',
            textColor: Colors.black87,
            color: Colors.lime.shade300,
            onPressed: _singInAnonymously,
          ),
        ],
      ),
    );
  }
}
