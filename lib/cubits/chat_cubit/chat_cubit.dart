import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
   List<MessageModel> messagesList = [];

 void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessageField: message,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
    } catch (e) {
      emit(ChatError());
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList = [];
      for(var message in event.docs) {
        messagesList.add(MessageModel.fromJson(message, message.id));
      }
      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
