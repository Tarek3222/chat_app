part of 'chat_cubit.dart';


abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  List<MessageModel> messagesList;

  ChatSuccess({required this.messagesList});
}

final class ChatError extends ChatState {}
