import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  const HomePage({Key? key,required this.auth}) : super(key: key);
  Future<void> _singOut()async{
    try {
      await auth.signOut();
    }catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
        ),
        actions: [
          FlatButton(
              onPressed: _singOut,
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
