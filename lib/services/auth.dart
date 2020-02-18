import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_basic/models/user.dart';
import 'package:firestore_basic/services/database.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid : user.uid): null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //anon signin
  Future signInAnon() async {
    try
    {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and pass

  Future registerEmailPass(String email,String password) async{
    try
    {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;
      // await user.sendEmailVerification();
      await Database(uid: user.uid).updateUserData('0', 'New User', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //sign in wth email and pass

  Future signInEmailPass(String email,String password) async{
    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }





//sign out 

  Future signOut()async {
    try{
      await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
    
  }
}