import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signIn2(String email, String password);

  Future<FirebaseUser> signUp2(String email, String password);

  Future<FirebaseUser> getCurrentUser2();

  Future<void> sendEmailVerification2();

  Future<void> signOut2();

  Future<bool> isEmailVerified2();

  Future<void> changeEmail2(String email);

  Future<void> changePassword2(String password);

  Future<void> deleteUser2();

  Future<void> sendPasswordResetMail2(String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn2(String email, String password) async {
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  Future<FirebaseUser> signUp2(String email, String password) async {
    AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<FirebaseUser> getCurrentUser2() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut2() async {
    print('Sesión Cerrada desde SignOut2');
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification2() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified2() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> changeEmail2(String email) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updateEmail(email).then((_) {
      print("Succesfull changed email");
    }).catchError((error) {
      print("email can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> changePassword2(String password) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> deleteUser2() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail2(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

}