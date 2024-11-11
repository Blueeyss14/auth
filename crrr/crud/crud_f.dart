import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  static Future<void> createItem(String name) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    await collectionReference.add({'name' : name});
  }

  static Stream<QuerySnapshot> readItem() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    return collectionReference.orderBy("name").snapshots();
  }

  static Future<void> updateItem(String name, String id) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    await collectionReference.doc(id).update({'name': name});
  }

  static Future<void> deleteItem(String id) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    await collectionReference.doc(id).delete();
  }
}