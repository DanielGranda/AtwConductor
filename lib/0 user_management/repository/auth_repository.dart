import 'package:antawaschool/0%20user_management/services/auth_services_firebase.dart';
import 'package:antawaschool/0%20user_management/services/auth_serviesFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'firebase_auth_api.dart';

class AuthRepositoryFirebase {
  //final _firebaseAuthAPI = FirebaseAuthAPI();
  final _firebaseAuthApiService = AuthServiceFirebaseApi();
  final _firebaseAuthApiService2 = Auth();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;

  /////////////ESTATUS//////////
Stream<User> get onAuthStateChanged{
  return _firebaseAuthApiService.onAuthStateChanged;}

  ////CURRENT USER///
 Future<User> currentUserFirbase()=>
_firebaseAuthApiService.currentUserFirbase();
  /////////////SIGN IN ANONYMOUS//////////
  Future<User>signInAnonymously() => _firebaseAuthApiService.signInAnonymously();

  /////////////SIGN IN GOOGLE//////////
  Future<User>signInWithGoogle() => _firebaseAuthApiService.signInWithGoogle();

  /////////////SIGN UP GOOGLE//////////
  Future<User>registroWithPasswordAndEmail(String email, String password) =>
      _firebaseAuthApiService.createUserWithEmailAndPassword(email, password);

  /////////////SIGN IN USER AND PASSWORD//////////
   Future<User>signInWithPasswordAndEmail(String email, String password) =>
      _firebaseAuthApiService.signInWithEmailAndPassword(email, password);

  /////////////SIGN OUT GOOGLE//////////
  Future<void>signOut() => _firebaseAuthApiService.signOut();
  
  /////////////ENVIO MAIL DE CUENTA//////////
 Future<void> sendEmailVerification()  => _firebaseAuthApiService.sendEmailVerification();

   /////////////CUENTA VERIFICADA//////////
Future<bool> isEmailVerified() => _firebaseAuthApiService.isEmailVerified();

   /////////////CAMBIAR PASSWORD//////////
Future<void> changePassword(String password) => _firebaseAuthApiService.changePassword(password);


   /////////////OLVIDÓ CONTRASEÑA//////////
  Future<void> olvidoPassword(String email) => _firebaseAuthApiService.sendPasswordResetMail(email);



  ///////////////////////////////////////OPCION 2//////////////////////////////////

   /////////////SIGN IN USER AND PASSWORD 2//////////

Future<FirebaseUser> signInWithEmailAndPassword2(String email, String password) =>
_firebaseAuthApiService2.signIn2(email, password);

   /////////////CREATE USER AND PASSWORD 2//////////
Future<FirebaseUser> signUp2(String email, String password) =>
_firebaseAuthApiService2.signUp2(email, password);

/////////////CURRENT USER 2//////////
 Future<FirebaseUser> getCurrentUser2() =>
 _firebaseAuthApiService2.getCurrentUser2();

 /////////////CERRAR SESIÓN2//////////
 Future<void> signOut2()=>
_firebaseAuthApiService2.signOut2();

 /////////////VERIFICACIÓN DE MAIL2//////////
  Future<void> sendEmailVerification2() =>
_firebaseAuthApiService2.sendEmailVerification2();

 /////////////VERIFICACIÓN DE MAIL RESPUESTA2//////////
Future<bool> isEmailVerified2() =>
_firebaseAuthApiService2.isEmailVerified2();


 /////////////CAMBIAR MAIL2 //////////
 Future<void> changeEmail2(String email) =>
 _firebaseAuthApiService2.changeEmail2(email);


 /////////////CAMBIAR PASSWORD2 //////////
 Future<void> changePassword2(String password)=>
  _firebaseAuthApiService2.changePassword2(password);

   /////////////ELIMINAR USUARIO //////////
 Future<void> deleteUser2() =>
 _firebaseAuthApiService2.deleteUser2();

 /////////////ENVIAR MAIL RESET PASWOORD //////////
  Future<void> sendPasswordResetMail2(String email) =>
_firebaseAuthApiService2.sendPasswordResetMail2(email);


}
