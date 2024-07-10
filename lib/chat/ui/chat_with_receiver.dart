import 'package:ayna_chat/chat/bloc/chat_bloc.dart';
import 'package:ayna_chat/chat/ui/message_tile.dart';
import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:ayna_chat/widgets/custom_small_button.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:ayna_chat/widgets/logout_button.dart';
import 'package:ayna_chat/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWithReceiver extends StatefulWidget {
  String receiver;
  ChatWithReceiver({
    super.key,
    required this.receiver,
  });

  @override
  State<ChatWithReceiver> createState() => _ChatWithReceiverState();
}

class _ChatWithReceiverState extends State<ChatWithReceiver> {
  ChatBloc chatBloc = ChatBloc();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    chatBloc.add(ChatSessionEvent(receiver: widget.receiver));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      bloc: chatBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChatLoadingState:
            return Scaffold(
              appBar: AppBar(
                title: CustomText(text: widget.receiver, size: 22),
                actions: const [LogoutButton()],
              ),
              body: const Center(child: CircularProgressIndicator()),
            );

          case ChatSessionLoadedState:
            final myState = state as ChatSessionLoadedState;
            List conversationWidgets = [];
            myState.conversation.forEach((message) {
              conversationWidgets.add(MessageTile(message: message));
            });
            return Scaffold(
              appBar: AppBar(
                title: CustomText(text: widget.receiver, size: 22),
                actions: const [LogoutButton()],
              ),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: CustomText(
                              text: " Conversation with ${widget.receiver}",
                              size: 20),
                        ),
                        ...conversationWidgets
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: CustomTextFormField(
                                  controller: messageController,
                                  hintText: "Write a message",
                                  obscureText: false),
                            ),
                            CustomSmallButton(text: "Send", onPressed: () {})
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ]),
            );
          case ChatErrorState:
          default:
            return Scaffold(
              appBar: AppBar(
                title: CustomText(text: widget.receiver, size: 22),
                actions: const [LogoutButton()],
              ),
              body: Column(children: [
                Text(
                    "There was some error fetching conversation ${state.runtimeType}"),
              ]),
            );
        }
      },
    );
  }
}
