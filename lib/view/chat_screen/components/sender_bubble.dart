import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  // Verificando se o campo 'created_on' existe e é do tipo Timestamp
  var t = (data['created_on'] != null && data['created_on'] is Timestamp) 
      ? (data['created_on'] as Timestamp).toDate() 
      : DateTime.now();

  var time = intl.DateFormat("h:mma").format(t);

  // Verifica se o campo 'msg' existe antes de tentar acessá-lo
  String msg = data.data().toString().contains('msg')
      ? data['msg']
      : "Mensagem não disponível"; // Mensagem padrão caso não exista o campo

  // Log para verificar a mensagem no console
  print("Mensagem recebida: ${data['msg']}");
  print("Hora da mensagem: $time");


  return Container(
    padding: const EdgeInsets.all(12), // Ajuste o padding conforme necessário
    margin: const EdgeInsets.only(bottom: 8),
    decoration: const BoxDecoration(
      color: redColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    child: Column(
      // Alinhar o texto corretamente
      children: [
        "${data['msg']}".text.black.size(16).make(), // Tamanho do texto ajustado
        10.heightBox,
        time.text.color(whiteColor.withOpacity(0.5)).make(), // Exibir a hora formatada
      ],
    ),
  );
}
