import 'package:chat_app/constants.dart';

class MessageModel{
  String message;
  String id;
  String? realId;

  MessageModel({required this.message, required this.id,this.realId});
 factory MessageModel.fromJson(json,id){
  return  MessageModel(message: json[kMessageField], id: json['id'],realId: id);
 }

}