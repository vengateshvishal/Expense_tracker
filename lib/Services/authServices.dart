import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<Authservices> authservices = ValueNotifier(Authservices());

class Authservices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password
  }) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<void> resetPassword({required String email}) async {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> deletedAccount({
  required String email,
  required String password,
}) async {
  AuthCredential credential = EmailAuthProvider.credential(
    email: email,
    password: password,
  );
  await currentUser!.reauthenticateWithCredential(credential);
  await currentUser!.delete();
  await firebaseAuth.signOut();
}
}
