import 'package:c_test_firebase/crud/crud_f.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill the blank")));
                      } else {
                        CRUD.createItem(nameController.text);
                        nameController.clear();
                      }
                    },
                    child: const Text("Create")),
              ],
            ),

              Expanded(
                child: StreamBuilder(
                    stream: CRUD.readItem(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      if (!snapshot.hasData) {
                        return const Text("No Data");
                      }
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data?.docs[index];
                
                            return Card(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item?['name']),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: const Text("Edit Item"),
                                          content: TextField(
                                            controller: editController,
                                            decoration: const InputDecoration(
                                              labelText: "New Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(onPressed: () {
                                              Navigator.pop(context);
                                            }, child: const Text("Cancel")),
                                            TextButton(onPressed: () {
                                              if (editController.text.isEmpty) {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill the blank")));
                                              } else {
                                                CRUD.updateItem(editController.text, item!.id);
                                                Navigator.pop(context);
                                              }


                                            }, child: const Text("Edit")),
                                          ],
                                        ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit),)
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    CRUD.deleteItem(item!.id);
                                  },icon: const Icon(Icons.delete),),
                              ),
                            );
                          },);
                    },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
