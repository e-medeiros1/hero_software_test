import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserAuthController extends GetxController {
  final FirebaseAuth instance = FirebaseAuth.instance;
  late final Rx<User?> user;

  Future toastMessage(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 17);
  }

  Future<void> loginWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await instance.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        toastMessage('Usuário não encontrado!');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        toastMessage('Senha ou e-mail incorretos!');
      }
    } catch (e) {
      log('ERROR FIREBASE', error: e);
      toastMessage('Erro ao logar, tente novamente!');
    }
    update();
  }

  Future<void> createAccount({
    required String username,
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        toastMessage('Este e-mail já está em uso!');
      } else if (e.code == 'user-not-found') {
        log('User not found, maybe have been deleted.');
        toastMessage('Usuário não cadastrado!');
      }
    } catch (e) {
      log('ERROR FIREBASE', error: e);
      toastMessage('Erro ao acessar conta, tente novamente!');
    }
    update();
  }

  resetPassword({required String email}) async {
    await instance.sendPasswordResetEmail(email: email).catchError(
          (error) => toastMessage('Erro ao recuperar senha, tente novamente!'),
        );
  }

  signOut({required BuildContext context}) async {
    try {
      await instance.signOut();
    } on FirebaseAuthException catch (e) {
      log('Não foi possível sair, tente novamente', error: e);
      toastMessage('Erro ao sair, tente novamente!');
    }
    update();
  }
}
