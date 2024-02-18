import 'package:chat_app/helper/firebase_api.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes:
      {
        LoginScreen.id : (context) => const LoginScreen(),
        RegisterScreen.id : (context) => const RegisterScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        SplashScreen.id : (context) => const SplashScreen()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
    );
  }
}
