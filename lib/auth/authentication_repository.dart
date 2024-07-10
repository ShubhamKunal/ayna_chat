import 'package:ayna_chat/router/routes.dart';
import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer';
import '../../utils/functions.dart' as functions;
import 'package:flutter/material.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signUp(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      functions.showSnackbarWithColor(context, e.code, Colors.red);
    }
  }

  Future<User?> logIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      functions.showSnackbarWithColor(context, e.code, Colors.red);
    }
  }

  Future<void> logOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    context.go("/");
  }
}
