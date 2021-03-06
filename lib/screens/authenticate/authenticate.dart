import 'package:firestore_basic/screens/authenticate/signIn.dart';
import 'package:firestore_basic/screens/authenticate/signup.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showSignIn?SignIn(toggleView:toggleView):Register(toggleView:toggleView);
  }
}