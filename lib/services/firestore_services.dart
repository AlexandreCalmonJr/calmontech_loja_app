import 'package:emart_app/consts/firebase_const.dart';

class FirestoreServices{
  // data users data
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }
  }
