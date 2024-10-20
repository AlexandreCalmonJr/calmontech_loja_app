import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImagemLink = ''.obs;
  var isloading = false.obs;
  // textfield
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var oldpasswordController = TextEditingController();
  
  

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality:50) ;

      if (
        img == null
        ) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(
        context,
        msg: e.toString(),
      );
    }
  }
  
  uploadProfileImage() async {
  try {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${auth.currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagemLink.value = await ref.getDownloadURL();
  } catch (e) {
    print("Erro ao carregar imagem: $e");
  }
}


  updateProfile({
  required String name,
  required String password,
  required String img,
}) async {
  try {
    isloading.value = true;  // Inicia o carregamento

    var store = firestore.collection(usersCollection).doc(auth.currentUser!.uid);

    // Atualiza os dados no Firestore com a opção de mesclar (merge: true)
    await store.set({
      'name': name,
      'password': password,
      'img': img,
    }, SetOptions(merge: true));

    isloading.value = false;  // Finaliza o carregamento
  } catch (e) {
    isloading.value = false;  // Finaliza o carregamento em caso de erro
    print("Erro ao atualizar o perfil: $e");
  }
}


  // Função para alterar senha
changeAuthPassword({
  required String email,
  required String password,
  required String newpassword,
}) async {
  try {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await auth.currentUser!.reauthenticateWithCredential(cred).then((value) {
      auth.currentUser!.updatePassword(newpassword);
      Get.snackbar("Sucesso", "Senha alterada com sucesso");
    }).catchError((error) {
      print(error.toString());
      Get.snackbar("Erro", "Erro ao alterar senha: $error");
    });
  } catch (e) {
    print("Erro ao alterar senha: $e");
    Get.snackbar("Erro", "Erro ao alterar senha: $e");
  }
}


}
