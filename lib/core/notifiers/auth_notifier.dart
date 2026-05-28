import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((_) {
      // Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
      notifyListeners();
    });
  }
}
