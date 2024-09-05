import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  static Future<void> createItem(String name) async {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    await collectionReference.add({'name': name});
  }

  static Stream<QuerySnapshot> readItems() {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    return collectionReference.orderBy('name').snapshots();

    //orderBy == Ascending
  }

  static Future<void> updateItem(String name, String id) async {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    await collectionReference.doc(id).update({'name': name});
  }

  static Future<void> deleteItem(String id) async {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');
    await collectionReference.doc(id).delete();
  }
}
