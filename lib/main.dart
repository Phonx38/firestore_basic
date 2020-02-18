import 'package:firestore_basic/models/user.dart';
import 'package:firestore_basic/services/auth.dart';
import 'package:firestore_basic/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main() =>runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat-Medium'),
        home: Wrapper()
      ),
    );
      
  }
}

