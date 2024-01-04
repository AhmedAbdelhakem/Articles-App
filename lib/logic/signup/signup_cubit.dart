import 'package:articles/components/register_component.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  late String username;
  late String email;
  late String phone;

  void register({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    this.username = username;
    this.email = email;
    this.phone = phone;

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        _insertUserData();
      },
    ).catchError(
      (error) {
        if (error is FirebaseAuthException && error.code == 'weak-password') {
          emit(RegisterFailureState("The password provided is too weak."));
        } else if (error is FirebaseAuthException &&
            error.code == 'email-already-in-use') {
          emit(RegisterFailureState(
              "The account already exists for that email."));
        } else {
          emit(RegisterFailureState(error.toString()));
        }
      },
    );
  }

  void _insertUserData() {
    MyUser user = MyUser(
        username: username,
        email: email,
        phone: phone,
        userId: FirebaseAuth.instance.currentUser!.uid);

    print(user.toJson());

    FirebaseFirestore.instance
        .collection("articleUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson())
        .then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterFailureState(error.toString()));
    });
  }
}
