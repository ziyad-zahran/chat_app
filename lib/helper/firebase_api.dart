import 'package:chat_app/main.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> handleBackGroundMessage(RemoteMessage message)
async{
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('playLoad : ${message.data}');
}
class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  void handleMessage(RemoteMessage? message)
  {
      if(message==null) return;
      navigatorKey.currentState?.pushNamed(
          ChatScreen.id,
          arguments: message,
      );
  }

  Future<void> initPushNotifications()
  async{
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);

  }

  Future<void> initNotifications()
  async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token : $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
    initPushNotifications();
  }

}