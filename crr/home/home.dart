import 'package:c_test_firebase/crud/crud_f.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
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
                    IconButton(onPressed: () {
                      CRUD.createItem(nameController.text);
                      nameController.clear();
                    },
                        icon: Text("Create")),
                  ],
                ),
              ),

              StreamBuilder(
                  stream: CRUD.readItem(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text("No Data Available"));
                    }
                    return Expanded(
                      child: ListView.builder(
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
                                      IconButton(onPressed: () {
                                        editController.text = item?['name'];
                                        showDialog(
                                          context: context, builder: (context) => AlertDialog(
                                          title: const Text("Edit Item"),
                                          content: TextField(
                                            controller: editController,
                                            decoration: const InputDecoration(
                                              labelText: 'New Name',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(onPressed: () {
                                              Navigator.pop(context);
                                            }, child: Text("Cancel")),
                                            ElevatedButton(onPressed: () {
                                              if (editController.text.isNotEmpty) {
                                                CRUD.updateItem(editController.text, item!.id);
                                                Navigator.pop(context);
                                              }
                                            }, child: Text("Edit"))
                                          ],
                                        ),
                                        );
                                        }, icon: Icon(Icons.edit),
                                      ),
                                      IconButton(onPressed: () {
                                        showDialog(context: context,
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
                                      }, icon: Icon(Icons.delete),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        ,),
                    );
                  }
                  ,)
            ],
          ),
        ),
      ),
    );
  }
}
