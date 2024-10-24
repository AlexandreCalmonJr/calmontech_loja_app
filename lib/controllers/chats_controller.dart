import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {

  // Variáveis de controle
  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = auth.currentUser!.uid;
  var msgController = TextEditingController();
  String? chatDocId;

  @override
  void onInit() {
    getChatId(); // Recupera ou cria um ID de chat
    super.onInit();
  }

  // Função para obter ou criar o ID do chat
  getChatId() async {
    try {
      QuerySnapshot snapshot = await chats
          .where('users', isEqualTo: {
            friendId: null,
            currentId: null,
          })
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Chat já existe, recupera o ID
        chatDocId = snapshot.docs.single.id;
      } else {
        // Chat não existe, cria um novo
        DocumentReference newChat = await chats.add({
          'create_on': FieldValue.serverTimestamp(),
          'last_msg': '',
          'users': {
            friendId: null,
            currentId: null,
          },
          'toId': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': senderName,
          'messages': [],
        });

        chatDocId = newChat.id; // Armazena o ID do novo chat
      }
    } catch (e) {
      print('Erro ao obter ou criar o ID do chat: $e');
    }
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
