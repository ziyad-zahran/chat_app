import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_password_text_field.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email,password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool isSign = false;
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,),
            child: ListView(
              children: [
                const SizedBox(height: 75,),
                Image.asset(
                  logo,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomTextField(hint: 'Login',
                  icon: Icons.person,
                  onChanged:(data){
                  email=data;
                  } ,),
                const SizedBox(height: 10,),
                CustomPasswordTextField(hint: 'Password',
                  pIcon: Icons.lock,
                  sIcon: Icons.remove_red_eye,
                  isSecure: isSecure,
                  onTap: ()
                  {
                    setState(() {
                      if (isSecure) {
                        isSecure = false;
                      }
                      else
                        {
                          isSecure=true;
                        }
                    });
                  },
                  onChanged: (data)
                {
                  password=data;
                },),
                const SizedBox(height: 10,),
                CustomButton(text: 'Login',
                  onTap: () async{
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      await signInUser();
                    }
                    isLoading = false;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\t have an acount ?   ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text('Register now',
                        style: TextStyle(
                          color: secColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    try {
      UserCredential user =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.of(context).pushNamedAndRemoveUntil
        (
          ChatScreen.id,
          arguments: email,
              (Route<dynamic> route) => false
      );
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        showSnackBar(context, 'user-not-found');
      } else if (ex.code == 'wrong-password') {
        showSnackBar(context, 'wrong-password');
      } else {
        showSnackBar(context, ex.code);
      }
    }
  }
}
