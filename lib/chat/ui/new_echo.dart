import 'package:ayna_chat/chat/bloc/chat_bloc.dart';
import 'package:ayna_chat/chat/ui/message_tile.dart';
import 'package:ayna_chat/websocket/websocket_services.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NewEcho extends StatefulWidget {
  const NewEcho({super.key});

  @override
  State<NewEcho> createState() => _NewEchoState();
}

class _NewEchoState extends State<NewEcho> {
  final messageController = TextEditingController();
  late WebSocketService webSocketService;
  final List<String> messages = [];
  List conversationWidgets = [];
  ChatBloc chatBloc = ChatBloc();

  @override
  void initState() {
    super.initState();
    webSocketService = WebSocketService('wss://echo.websocket.org');
    webSocketService.messages.listen((message) {
      setState(() {
        messages.add("Mr. Echo: $message");
      });
    });
  }

  @override
  void dispose() {
    webSocketService.dispose();

    super.dispose();
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      webSocketService.sendMessage(messageController.text);
      setState(() {
        messages.add('You: ${messageController.text}');
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              chatBloc.add(ChatEchoEvent(messages: messages));
              log(messages.toString());
              webSocketService.dispose();
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const CustomText(text: "Echo Room", size: 22),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  message: messages[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: CustomTextFormField(
                        controller: messageController,
                        hintText: "send message",
                        obscureText: false)),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: HexColor("3E60AD"),
                  ),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
