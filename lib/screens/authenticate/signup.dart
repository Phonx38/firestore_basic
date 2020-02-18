import 'package:firestore_basic/services/auth.dart';
import 'package:firestore_basic/shared/lading.dart';
import 'package:firestore_basic/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({
    this.toggleView,
  });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        elevation: 3.0,
        title: Text('Sign Up '),
        actions: <Widget>[
          RaisedButton(
            child: Text('Sign In',style: TextStyle(color: Colors.white),),
            color: Colors.transparent,
            onPressed: (){
              widget.toggleView();
            },
            elevation: 3.0,
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator:validateEmail ,
                  decoration: textInputDecoration,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),
                 SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val)=> val.length < 6 ? 'Password should have atleast 6 char.':null,
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.pink[300],
                  child: Text('Sign Up'),
                  elevation: 3.0,
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerEmailPass(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Not a valid email';
                          loading = false;
                          });
                      }
                    }
                  },
                ),
                SizedBox(height: 15.0,),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }