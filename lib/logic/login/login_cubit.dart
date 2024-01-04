import 'dart:convert';
import 'package:articles/components/register_component.dart';
import 'package:articles/models/myshared.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialStates());

  void login({required String email, required String password}) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        emit(LoginFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        emit(LoginFailure("Wrong password provided for that user."));
      } else {
        if (kDebugMode) {
          print(e);
        }
        emit(LoginFailure(e.toString()));
      }
    }
  }


  void saveUserData(MyUser user) {
    MyShared.putString(key: "user", value: jsonEncode(user));

    MyShared.putString(key: "username", value: user.username);

    emit(LoginSuccess());
  }

}