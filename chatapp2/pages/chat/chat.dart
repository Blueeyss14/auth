import 'package:c_test_firebase/Auth/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  const ChatPage({super.key, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
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
          'senderId' : _senderId,
          'receiverId' : widget.receiverId,
          'text' : text,
          'timestamp' : Timestamp.now(),
        });
        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send message $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('messages').orderBy('timestamp')
                      .snapshots(),
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error : ${snapshot.error}'),);
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No Message'));
                    }

                    final messages = snapshot.data!.docs.where((doc) {
                      final data = doc.data();
                      final senderId = data['senderId'];
                      final receiverId = data['receiverId'];
                      return (senderId == _senderId && receiverId == widget.receiverId) ||
                          (senderId == widget.receiverId && receiverId == _senderId);
                    }).toList();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                          _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 1000);
                        }
                    });

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index].data();
                        final isSender = message['senderId'] == _senderId;

                        return Row(
                          mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.45,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  topRight: const Radius.circular(10),
                                  bottomLeft: isSender ? const Radius.circular(10) : const Radius.circular(0),
                                  bottomRight: isSender ? const Radius.circular(0) : const Radius.circular(10),
                                ),
                                color: isSender ? Colors.blue : Colors.grey,
                              ),
                              child: Text(
                                message['text'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isSender ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );

                      },
                    );
                  },
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    )

                ),
                IconButton(
                    onPressed: _sendMessage,
                      icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
