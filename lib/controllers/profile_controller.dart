import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';


class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var isloading = false.obs;

  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var oldpasswordController = TextEditingController();

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var profileImagemLink = '';

  

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);

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
    var filename = basename(profileImgPath.value);
    var destination = 'images/${auth.currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagemLink = await ref.getDownloadURL();
    
    
  }

  updateProfile({
    name,
    password,
    imgUrl,
  }) async {
    isloading.value = true;
    var store = firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'img': imgUrl,
    },
    SetOptions(merge: true)

    );
    isloading(false);
  }

  changeAuthPassword({
    email,
    password,
    newpassword
  }
  ) async {
    final cred = EmailAuthProvider.credential(
      email: email, password: password
    );
    await auth.currentUser!.reauthenticateWithCredential(cred).then((value){
      auth.currentUser!.updatePassword(newpassword);
    }).catchError((error){
      print(error.toString());
    });



  }




}
