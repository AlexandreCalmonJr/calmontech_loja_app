import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data, bool isCurrentUser) {
  var t = (data['create_on'] != null && data['create_on'] is Timestamp)
      ? (data['create_on'] as Timestamp).toDate()
      : DateTime.now();

  var time = intl.DateFormat("h:mma").format(t);
  String msg = data.data().toString().contains('msg') ? data['msg'] : "Mensagem não disponível";

  return Directionality(
    textDirection: data['uid'] == FirebaseAuth.instance.currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color:  data['uid'] == FirebaseAuth.instance.currentUser!.uid ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isCurrentUser ? const Radius.circular(20) : const Radius.circular(0),
          bottomRight: isCurrentUser ? const Radius.circular(0) : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msg,
            style: TextStyle(
              color: isCurrentUser ? whiteColor : Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: isCurrentUser ? whiteColor.withOpacity(0.7) : Colors.black.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
