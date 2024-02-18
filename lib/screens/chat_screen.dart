import 'dart:js';

import 'package:chat_app/components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'BubbleScreen';
  final _scrollController = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(KMessageCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    final message = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder(
      stream: messages.orderBy(KAboutAt,descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
      if(snapshot.hasData)
        {
          List<Message> messageList = [];
          for(int i=0; i <snapshot.data!.docs.length; i++)
          {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    height: 40,
                  ),
                  const Text('Chat ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                      reverse: true,
                      itemCount: messageList.length,
                      itemBuilder: (context,index)
                      {
                        return messageList[index].id == email ? ChatBubble(message: messageList[index])
                            : ChatBubbleForAnotherUser(message: messageList[index]);
                      }
          ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data)
                    {
                      messages.add({
                        KMessagedata :data,
                        KAboutAt : DateTime.now(),
                        KId : email,
                      });
                      controller.clear();
                      _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: KPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: KPrimaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.orangeAccent,
                          ),

                        )
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      else
        {
          return const Text('Loading');
        }
      }
    );
  }
}

