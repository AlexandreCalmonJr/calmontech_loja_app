// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId(); // Recupera ou cria um ID de chat
    super.onInit();
  }

  // Variáveis de controle
  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = auth.currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocId;
  var chatDoc = FirebaseFirestore.instance.collection(chatsCollection).doc();
  var isLoading = false.obs;

  // Função para obter ou criar o ID do chat
  getChatId() async {
    isLoading.value = true;
    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            chatDocId = querySnapshot.docs.single.id;
          } else {
            chats.add({
              'create_on': null,
              'last_msg': '',
              'users': {
                friendId: null,
                currentId: null,
              },
              'toId': friendId,
              'fromId': currentId,
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              {
                chatDocId = value.id;
              }
            });
          }
        });
    isLoading.value = false;
  }

  // Função para enviar mensagens
  sendMsg(String? msg) async {
    if (msg != null && msg.trim().isNotEmpty && chatDocId != null) {
      try {
        // Atualiza o documento principal do chat com a última mensagem
        await chats.doc(chatDocId).update({
          'create_on': FieldValue.serverTimestamp(),
          'last_msg': msg,
          'toId': friendId,
          'fromId': currentId
        });

        // Adiciona a mensagem à subcoleção de mensagens
        await chats.doc(chatDocId).collection(messagesCollection).add({
          'create_on': FieldValue.serverTimestamp(),
          'msg': msg,
          'uid': currentId,
          'toId': friendId,
        });

        // Limpa o campo de texto após o envio
        msgController.clear();
      } catch (e) {
        print('Erro ao enviar mensagem: $e');
      }
    }
  }
}
