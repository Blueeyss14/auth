import 'package:c_test_firebase/Auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
