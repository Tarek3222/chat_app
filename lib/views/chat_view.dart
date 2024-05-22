import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  static const String id = 'ChatView';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
       if(snapshot.hasData){
        List<MessageModel>messagesList=[];   
        for(int i=0;i<snapshot.data!.docs.length;i++){
          MessageModel messageModel=MessageModel.fromJson(snapshot.data!.docs[i]);
          messagesList.add(messageModel);
        }   
        return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/images/scholar.png',
          height: 50,),
          const Text(' Chat',
          style: TextStyle(
            color: Colors.white,
          )
          ),
        ],),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return messagesList[index].id==email?  ChatBubble(
                messageModel: messagesList[index],
              ): ChatBubbleForFriend(
                messageModel: messagesList[index],
              );
            },
            controller: scrollController,
            reverse: true,
            itemCount: messagesList.length,),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (value){
                messages.add({
                  kMessageField: value,
                  kCreatedAt:DateTime.now(),
                  'id': email  ,
                  });
                controller.clear();
                scrollController.animateTo(
                   0,
                   duration: const Duration(microseconds: 300),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration( 
                hintText: 'send a message',
                suffixIcon: const Icon(Icons.send,
                color: kPrimaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              )
            ),
          ),
        ],
      ),
    );
       }else{
        return const Text('loading');
       }
      },
    );
  }
}

