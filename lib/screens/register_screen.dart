import 'package:chat_app/components/custom_password_text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../helper/show_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String id = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email,password;

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  logo,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  icon: Icons.person,
                  onChanged: (data) {
                    email = data;
                  },
                  hint: 'email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomPasswordTextField(
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
                  onChanged: (data) {
                    password = data;
                  },
                  hint: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      await registerUser();
                    }
                    isLoading = false;
                    setState(() {});
                  },
                  text: 'Register',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an acount ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' Sign in',
                        style: TextStyle(
                          color: secColor ,
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
  Future<void> registerUser() async {
    try {
      UserCredential user =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      showSnackBar(context, 'Success');
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        showSnackBar(context, 'weak-password');
      } else if (ex.code == 'email-already-in-use') {
        showSnackBar(context, 'email-already-in-use');
      } else {
        showSnackBar(context, ex.code);
      }
    }
  }

}
