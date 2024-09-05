import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDOperations extends StatefulWidget {
  @override
  _CRUDOperationsState createState() => _CRUDOperationsState();
}

class _CRUDOperationsState extends State<CRUDOperations> {
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('items');

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Firebase'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty) {
                  showSnackBar(context, "please fill the blank");
                } else {
                  createItem(nameController.text);
                  nameController.clear();
                }
              },
              child: Text('Create'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data?.docs[index];
                      return Card(
                        child: ListTile(
                          title: Text(item?['name']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  nameController.text = item?['name'];
                                  showDialog(
                                    context: context,
                                    builder: (context) => UpdateItemDialog(
                                      nameController: nameController,
                                      onSave: () {
                                        if (nameController.text.isEmpty) {
                                          showSnackBar(context, "please fill the blank");
                                        } else {
                                          updateItem(item?.id, nameController.text);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DeleteItemDialog(
                                      onDelete: () {
                                        deleteItem(item?.id);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createItem(String name) {
    collectionReference.add({'name': name});
  }

  void updateItem(String? id, String name) {
    if (id != null) {
      collectionReference.doc(id).update({'name': name});
    }
  }

  void deleteItem(String? id) {
    if (id != null) {
      collectionReference.doc(id).delete();
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class UpdateItemDialog extends StatelessWidget {
  final TextEditingController nameController;
  final VoidCallback onSave;

  UpdateItemDialog({required this.nameController, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Item'),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'New Name',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          child: Text('Save'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
        ),
      ],
    );
  }
}

class DeleteItemDialog extends StatelessWidget {
  final VoidCallback onDelete;

  DeleteItemDialog({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Item'),
      content: Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onDelete,
          child: Text('Delete'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
