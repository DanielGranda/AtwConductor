import 'package:antawaschool/0%20user_management/model/user_adm_model.dart';
import 'package:antawaschool/0%20user_management/repository/auth_repository.dart';
import 'package:antawaschool/0%20user_management/repository/cloud_firestore_repository.dart';
import 'package:antawaschool/0%20user_management/services/auth_services_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
final _authRepositoryFirebase = AuthRepositoryFirebase();

  /////////////ESTADO DE USUARIO//////////
 Stream<User> onAuthStateChanged() => _authRepositoryFirebase.onAuthStateChanged;
 
 
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;

    ////CURRENT USER///
 Future<User> currentUserFirbase()=>
_authRepositoryFirebase.currentUserFirbase();

  /////////////SIGN IN ANONYMOUS//////////
  Future<User>signInAnonymously() => _authRepositoryFirebase.signInAnonymously();
 
   /////////////SIGN IN GOOGLE//////////////
   Future<User>signInWithGoogle() => _authRepositoryFirebase.signInWithGoogle();

  /////////////SIGN UP PASSOORD//////////
  Future<User>registroWithPasswordAndEmail(String email, String password) =>
      _authRepositoryFirebase.registroWithPasswordAndEmail(email, password);

  /////////////SIGN IN PASSWORD//////////
  Future<User>signInWithPasswordAndEmail(String email, String password) =>
      _authRepositoryFirebase.signInWithPasswordAndEmail(email, password);

  /////////////SIGN OUT GOOGLE//////////
   Future<void>signOut() => _authRepositoryFirebase.signOut();

 /////////////REGISTRO BASDE DE DATOS USER//////////
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  updateUserData(UserAdmin user)=> _cloudFirestoreRepository.updateUserDataFirestore(user);

///////////////////////////////////////OPCION 2////////////////////////////

   /////////////SIGN IN USER AND PASSWORD 2//////////
   ///


   /////////////SIGN IN USER AND PASSWORD 2//////////

Future<FirebaseUser> signInWithEmailAndPassword2(String email, String password) =>
_authRepositoryFirebase.signInWithEmailAndPassword2(email, password);

   /////////////CREATE USER AND PASSWORD 2//////////
Future<FirebaseUser> signUp2(String email, String password) =>
_authRepositoryFirebase.signUp2(email, password);

/////////////CURRENT USER 2//////////
 Future<FirebaseUser> getCurrentUser2() =>
 _authRepositoryFirebase.getCurrentUser2();

 /////////////CERRAR SESIÓN2//////////
 Future<void> signOut2()=>
_authRepositoryFirebase.signOut2();

 /////////////VERIFICACIÓN DE MAIL2//////////
  Future<void> sendEmailVerification2() =>
_authRepositoryFirebase.sendEmailVerification2();

 /////////////VERIFICACIÓN DE MAIL RESPUESTA2//////////
Future<bool> isEmailVerified2() =>
_authRepositoryFirebase.isEmailVerified2();


 /////////////CAMBIAR MAIL2 //////////
 Future<void> changeEmail2(String email) =>
 _authRepositoryFirebase.changeEmail2(email);


 /////////////CAMBIAR PASSWORD2 //////////
 Future<void> changePassword2(String password)=>
  _authRepositoryFirebase.changePassword2(password);

   /////////////ELIMINAR USUARIO //////////
 Future<void> deleteUser2() =>
 _authRepositoryFirebase.deleteUser2();

 /////////////ENVIAR MAIL RESET PASWOORD //////////
  Future<void> sendPasswordResetMail2(String email) =>
_authRepositoryFirebase.sendPasswordResetMail2(email);

  @override
  void dispose() {}
}
