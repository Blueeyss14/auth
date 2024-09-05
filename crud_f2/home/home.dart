import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../crud/crud_f.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController editController = TextEditingController();

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Data')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("fill the blank")));
                      } else {
                        CRUD.createItem(nameController.text);
                        nameController.clear();
                      }
                    },
                    child: const Icon(Icons.add)),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: CRUD.readItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
                    return const Center(child: Text("No Data Available"));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = snapshot.data?.docs[index];

                      return Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item?['name']),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        editController.text = item?['name'];
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Edit Item"),
                                            content: TextField(
                                              controller: editController,
                                              decoration: const InputDecoration(
                                                labelText: 'New Name',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (editController.text.isNotEmpty) {
                                                    CRUD.updateItem(editController.text, item!.id);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text("Edit"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        editController.text = item?['name'];
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
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
                                                onPressed: () {
                                                  CRUD.deleteItem(item!.id);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Delete'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                        );
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
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
}
