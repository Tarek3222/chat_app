import 'package:chat_app/constants.dart';

class MessageModel{
  String message;
  String id;

  MessageModel({required this.message, required this.id});
 factory MessageModel.fromJson(json){
  return  MessageModel(message: json[kMessageField], id: json['id']);
 }

}