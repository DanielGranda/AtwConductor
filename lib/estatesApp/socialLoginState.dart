import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences _prefs;

  bool _loggedIn = false;
  bool _loading = true;
  FirebaseUser _user;

  LoginState() {
    loginState();
  }

  bool isloggedIn() => _loggedIn;
  bool isloading() => _loading;
  FirebaseUser currentUser() => _user;

  void login() async {
    _loading = true;
    notifyListeners();

    _user = await _handleSignIn();

    _loading = false;
    if (_user != null) {
      _prefs.setBool('isLoggedIn', true);
      _loggedIn = true;
      notifyListeners();
    } else {
      _loggedIn = false;
      notifyListeners();
    }
  }

  void logout() {
    _prefs.clear();
    _googleSignIn.signOut();
    //notifyListeners();
    _loggedIn = false;
    notifyListeners();
  }

  //Sing in Google
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Update the username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await user.user.updateProfile(userUpdateInfo);
    await user.user.reload();
    return user.user.uid;
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('isLoggedIn')) {
      _user = await _auth.currentUser();
      _loggedIn = _user != null;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }
}
