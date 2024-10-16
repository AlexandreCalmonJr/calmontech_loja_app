import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with StateMixin<User> {
  // instancia do firebase
  final auth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  
  

  // login metodo
  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;

    try {
      // Atribui o retorno do método de login ao userCredential
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException {
      // Exibe a mensagem de erro no toast
      VxToast.show(context, msg: "Falha no login. Verifique suas credenciais.");
    }

    // Retorna o UserCredential, que pode ser nulo em caso de erro
    return userCredential;
  }

// cadastro metodo
  Future<UserCredential?> signMethod(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential? userCredential;

    try {
      // Cria o usuário com email e senha
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      // Exibe a mensagem de erro no toast
      
    }

    // Retorna o UserCredential (pode ser null se a criação falhar)
    return userCredential;
  }

// storage data metodo
  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    store.set(
        {'name': name, 'password': password, 'email': email, 'imageUrl': '','id': auth.currentUser!.uid});
  }

  //cadastro entrada metodo
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
