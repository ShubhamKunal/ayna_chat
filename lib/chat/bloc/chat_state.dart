// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  List<String> receivers;
  ChatLoadedState({
    required this.receivers,
  });
}

class ChatErrorState extends ChatState {}

class ChatSendingState extends ChatState {}

class ChatSentState extends ChatState {}

class ChatSessionLoadedState extends ChatState {
  List conversation;
  ChatSessionLoadedState({
    required this.conversation,
  });
}
