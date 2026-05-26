import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grab_it/core/errors/exceptions.dart';
import 'package:grab_it/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:grab_it/features/auth/data/models/user_model.dart';

class AuthRemotDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemotDatasourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<String> sendOTP(String phoneNumber) async {
    // using Completer to turn Firebase's callback functions into a Future
    final completer = Completer<String>();

    await firebaseAuth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        completer.completeError(
          ServerException(e.message ?? 'Verification failed'),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Return the ID to our Repository!
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return completer.future;
  }

  @override
  Future<UserModel> verifyOTPAndLogin({
    required String verificationId,
    required String smsCode,
    required String name,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      // Verifying OTP with Firebase
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw const ServerException('Failed to login. Please try again.');
      }

      // Check if user already exists in Firestore
      final userDoc = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (userDoc.exists) {
        // Fetch existing user
        return UserModel.fromJson(userDoc.data()!);
      } else {
        // Create new user (Owner/User logic)
        final newUser = UserModel(
          id: firebaseUser.uid,
          name: name,
          mobileNumber: phoneNumber,
          address: address,
          role: 'user', // Default to user. manually upgrade owners in Firebase
        );
        await firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .set(newUser.toJson());
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Invalid OTP');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
