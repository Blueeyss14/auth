import 'package:c_test_firebase/Auth/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  const ChatPage({super.key, required this.receiverId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late final String _senderId;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _senderId = Provider.of<AuthServicesProvider>(context, listen: false).getCurrentUserId();
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('messages').add({
          'senderId': _senderId,
          'receiverId': widget.receiverId,
          'text': text,
          'timestamp': Timestamp.now(),
        });
        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim pesan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Tidak ada pesan.'));
                }

                final messages = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final senderId = data['senderId'];
                  final receiverId = data['receiverId'];
                  return (senderId == _senderId && receiverId == widget.receiverId) ||
                      (senderId == widget.receiverId && receiverId == _senderId);
                }).toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 1000,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                    );
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final isSender = message['senderId'] == _senderId;

                    return ListTile(
                      title: Align(
                        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.45,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          color: isSender ? Colors.blue : Colors.grey,
                          child: Text(
                            message['text'],
                            style: TextStyle(color: isSender ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
