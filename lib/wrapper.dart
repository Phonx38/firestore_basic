import 'package:firestore_basic/models/user.dart';
import 'package:firestore_basic/screens/authenticate/authenticate.dart';
import 'package:firestore_basic/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null ? Authenticate():Home();
   
    // if(user == null){
    //   return Authenticate();
    // }else{
    //   return Home();
    // }
  }
}