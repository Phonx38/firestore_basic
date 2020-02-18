

import 'package:firestore_basic/screens/home/settings_form.dart';
import 'package:firestore_basic/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:firestore_basic/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';
import 'package:firestore_basic/models/brew.dart';
                              



class Home extends StatelessWidget {

  

  AuthService _auth = AuthService();
  @override

  Widget build(BuildContext context) {

    void _showSettings(){
      showModalBottomSheet(context: context,builder: (context){
        
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingForm(),
        );
      });
  }
    return StreamProvider<List<Brew>>.value(
        value: Database().brew,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          
          elevation: 3.0,
          title: Text('Coffee',style: TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.transparent,
              icon : Icon(Icons.person,color: Colors.brown[800],),
              onPressed: () async{
                await _auth.signOut();
              },
              label: Text('Logout',style: TextStyle(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:3.0),
              child: FlatButton.icon(
                color: Colors.transparent,
                icon : Icon(Icons.settings,color: Colors.brown[800],),
                onPressed: () {
                  _showSettings();
                },
                label: Text('Settings',style: TextStyle(color: Colors.white),),
              ),
            ),
            
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList(),
          ),
      ),
    );
  }
}