import 'dart:async';
import 'package:ayna_chat/sqlite/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ayna_chat/utils/functions.dart' as functions;
import 'package:meta/meta.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatLoadingEvent>(chatLoadingEvent);
    on<ChatSendEvent>(chatSendEvent);
    on<ChatSessionEvent>(chatSessionEvent);
    on<ChatEchoEvent>(chatEchoEvent);
  }

  FutureOr<void> chatLoadingEvent(
      ChatLoadingEvent event, Emitter<ChatState> emit) async {
    List<String> myReceivers = [];
    emit(ChatLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await ChatDB().getDistinctConversationUsers().then((conversations) {
        myReceivers.addAll(conversations);
      });
    } catch (e) {
      emit(ChatErrorState());
    }
    emit(ChatLoadedState(receivers: myReceivers));
  }

  Future<void> chatSendEvent(
      ChatSendEvent event, Emitter<ChatState> emit) async {
    emit(ChatSendingState());
    List conversation = [];
    try {
      await ChatDB().insertChat({
        "sender": FirebaseAuth.instance.currentUser!.email ?? "user",
        "receiver": event.receiver,
        "text": event.text
      });
    } catch (e) {
      emit(ChatErrorState());
    }
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
    emit(ChatSentState(conversation: conversation));
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

  FutureOr<void> chatEchoEvent(
      ChatEchoEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      for (int i = 1; i < event.messages.length; i++) {
        var message = event.messages[i];
        if (message.startsWith("You:")) {
          await ChatDB().insertChat({
            "sender": FirebaseAuth.instance.currentUser!.email,
            "receiver": functions.extractRequestId(event.messages[0]),
            "text": message.split(':')[1],
          });
        } else {
          await ChatDB().insertChat({
            "sender": functions.extractRequestId(event.messages[0]),
            "receiver": FirebaseAuth.instance.currentUser!.email,
            "text": message.split(':')[1],
          });
        }
      }
    } catch (e) {
      emit(ChatErrorState());
    }
    List<String> myReceivers = [];
    try {
      await ChatDB().getDistinctConversationUsers().then((conversations) {
        myReceivers.addAll(conversations);
      });
    } catch (e) {
      emit(ChatErrorState());
    }
    emit(ChatLoadedState(receivers: myReceivers));
  }
}
