part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatLoadingEvent extends ChatEvent {}

class ChatSendEvent extends ChatEvent {
  String receiver;
  String text;
  ChatSendEvent({
    required this.receiver,
    required this.text,
  });
}

class ChatSessionEvent extends ChatEvent {
  String receiver;
  ChatSessionEvent({required this.receiver});
}

class ChatEchoEvent extends ChatEvent {
  List<String> messages;
  ChatEchoEvent({required this.messages});
}
