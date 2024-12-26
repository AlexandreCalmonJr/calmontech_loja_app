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
  var isLoading = false.obs;

  // Função para obter ou criar o ID do chat
  Future<void> getChatId() async {
    isLoading.value = true;
    try {
      var querySnapshot = await chats
          .where('users', arrayContainsAny: [friendId, currentId])
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        chatDocId = querySnapshot.docs.single.id;
      } else {
        var newChatDoc = await chats.add({
          'create_on': FieldValue.serverTimestamp(),
          'last_msg': '',
          'users': [friendId, currentId],
          'toId': friendId,
          'fromId': currentId,
          'friend_name': friendName,
          'sender_name': senderName,
        });
        chatDocId = newChatDoc.id;
      }
    } catch (e) {
      print('Erro ao obter ou criar chat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Função para enviar mensagens
  Future<void> sendMsg(String msg) async {
    if (msg.trim().isNotEmpty && chatDocId != null) {
      try {
        await chats.doc(chatDocId).update({
          'create_on': FieldValue.serverTimestamp(),
          'last_msg': msg,
        });
        await chats.doc(chatDocId).collection(messagesCollection).add({
          'create_on': FieldValue.serverTimestamp(),
          'msg': msg,
          'uid': currentId,
          'toId': friendId,
        });
        msgController.clear();
      } catch (e) {
        print('Erro ao enviar mensagem: $e');
      }
    }
  }
}
