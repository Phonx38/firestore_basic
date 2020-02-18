import 'package:firestore_basic/models/user.dart';
import 'package:firestore_basic/services/database.dart';
import 'package:firestore_basic/shared/lading.dart';
import 'package:flutter/material.dart';
import 'package:firestore_basic/shared/constants.dart';
import 'package:provider/provider.dart';


class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: Database(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your brew settings.',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.brown[400])),
                  SizedBox(height: 15.0,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText:'Name'),
                    validator: (val)=> val.isEmpty ? 'Please Enter a name.': null,
                    onChanged: (val)=>setState(()=>_currentName = val),
                  ),
                  SizedBox(height: 15.0,),
                  DropdownButtonFormField(
                    value: _currentSugar ?? userData.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val)=>setState(()=>_currentSugar = val),
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                    label: 'Strength',
                    value: (_currentStrength ??  userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ??  userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ??  userData.strength],
                    min: 100.0,
                    max:900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),

                  ),
                  RaisedButton(
                    color: Colors.pink[300],
                    child: Text('Update',style: TextStyle(color:Colors.white),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        await  Database(uid: user.uid).updateUserData(
                          _currentSugar ??userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                        );
                        Navigator.pop(context);
                      }
                    },

                  )
                ],
              ),
        );
        }else{
          return Loading();
        }
        
      }
    );
  }
}