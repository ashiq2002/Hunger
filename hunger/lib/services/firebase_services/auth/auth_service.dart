import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';

class MyAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get getCurrentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //user sign in with email and password
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //sign in with google
  signInWithGoogle() async{
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //auth detail for request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create google credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    //sign in a user
    return await _firebaseAuth.signInWithCredential(credential);
  }

  //user signup with email password
  Future<bool> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    }catch(e){
      debugPrint('Error : ${e.toString()}');
      return false;
    }
  }

  //sign out user
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  //reset/recover user password
  Future resetPassword({required String email}) async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    }on FirebaseAuthException catch(e){
      return e.message.toString();
    }
  }
}
