import 'package:ayna_chat/chat/bloc/chat_bloc.dart';
import 'package:ayna_chat/chat/ui/chat_tile.dart';
import 'package:ayna_chat/chat/ui/chat_with_receiver.dart';
import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AllChats extends StatefulWidget {
  const AllChats({super.key});

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  ChatBloc chatBloc = ChatBloc();
  @override
  void initState() {
    chatBloc.add(ChatLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      bloc: chatBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChatLoadingState:
            return const Center(child: CircularProgressIndicator());
          case ChatLoadedState:
            final myState = state as ChatLoadedState;
            if (myState.receivers.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: SvgPicture.asset("assets/cry.svg")),
                  const CustomText(text: "No Chats", size: 16),
                ],
              ));
            } else {
              return ListView.builder(
                  itemCount: myState.receivers.length,
                  itemBuilder: (context, index) {
                    return ChatTile(
                        receiver: myState.receivers[index],
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatWithReceiver(
                                    receiver: myState.receivers[index],
                                  )));
                          log(myState.receivers[index]);
                        });
                  });
            }
          case ChatErrorState:
            return const Column(
              children: [Text("Chats Error case")],
            );
          default:
            return const Column(
              children: [Text("Chats Default case")],
            );
        }
      },
    );
  }
}
