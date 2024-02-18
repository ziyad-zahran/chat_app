import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message
{
  final String message;
  final String id;
  final Timestamp time;
  Message(this.message, this.time, this.id);
  factory Message.fromJson(jsondata)
  {
    return Message(jsondata[KMessagedata],jsondata[KAboutAt],jsondata[KId]);
  }
}