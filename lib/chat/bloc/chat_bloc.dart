import 'dart:async';

import 'package:ayna_chat/chat/model/chat.dart';
import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'dart:developer';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatLoadingEvent>(chatLoadingEvent);
    on<ChatSendEvent>(chatSendEvent);
    on<ChatSessionEvent>(chatSessionEvent);
  }

  FutureOr<void> chatLoadingEvent(
      ChatLoadingEvent event, Emitter<ChatState> emit) async {
    List<String> myReceivers = [];
    emit(ChatLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await ChatDB()
          .getDistinctItems(FirebaseAuth.instance.currentUser!.email ?? "user")
          .then((receivers) {
        log("Receivers length:${receivers.length}");
        myReceivers.addAll(receivers);
      });
    } catch (e) {
      emit(ChatErrorState());
    }
    emit(ChatLoadedState(receivers: myReceivers));
  }

  Future<void> chatSendEvent(
      ChatSendEvent event, Emitter<ChatState> emit) async {
    emit(ChatSendingState());
    //TODO: SENDING OF CHAT
    try {
      await ChatDB().insertChat({
        "sender": FirebaseAuth.instance.currentUser!.email ?? "user",
        "receiver": event.receiver,
        "text": event.text
      });
    } catch (e) {
      emit(ChatErrorState());
    }
    emit(ChatSentState());
  }

  Future<void> chatSessionEvent(
      ChatSessionEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    List conversation = [];
    try {
      await ChatDB()
          .getConversation(
              FirebaseAuth.instance.currentUser!.email!, event.receiver)
          .then((messages) {
        messages.forEach((message) {
          if (message['sender'] == event.receiver) {
            conversation.add("${event.receiver}: ${message['text']}");
          } else {
            conversation.add("You: ${message['text']}");
          }
        });
      });
    } catch (e) {
      emit(ChatErrorState());
    }

    emit(ChatSessionLoadedState(conversation: conversation));
  }
}
