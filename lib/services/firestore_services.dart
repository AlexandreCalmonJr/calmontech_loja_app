import 'package:emart_app/consts/firebase_const.dart';

class FirestoreServices{
  // data users data
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
  }

  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: auth.currentUser!.uid).snapshots();
  }
   static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId)
  {
    return firestore
    .collection(chatsCollection)
    .doc(docId)
    .collection(messagesCollection)
    .orderBy(
      'created_on', 
      descending: false

      )
    .snapshots();
  }

  }
