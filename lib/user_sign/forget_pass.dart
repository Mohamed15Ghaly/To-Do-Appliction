import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_appliction/components/constants.dart';
import 'package:todo_appliction/user_sign/user_login.dart';

class User_Forget_Pass extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController Email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/signin_balls.png"),
          Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text_App(
                  string: "Forget password",
                  bold: true,
                  size: 25,
                  color: Color.fromARGB(255, 1, 137, 121),
                ),
                Gap(5),
                Text_App(
                    string: "Enter your registered email blew",
                    Shadow_Text: false,
                    color: Colors.grey,
                    bold: true,
                    size: 15),
                Gap(50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      defaultTextFormfield(
                        LabelHint: "Email address",
                        Control: Email,
                        Type: TextInputType.emailAddress,
                        prefix: Icons.email_rounded,
                      ),
                    ],
                  ),
                ),
                Gap(25),
                defaultMaterialButtom(
                    Width: MediaQuery.sizeOf(context).width,
                    string: "Send",
                    What_Fundction_do: () async {
                      if (Email.text.isEmpty)
                        defaultFlusbar(
                            message: "You must write your Email address",
                            Second: 3,
                            icon: Icons.warning_amber,
                            Title: "failed"
                        ).show(context);
                      else {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: Email.text.trim());
                        await Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: User_login(),
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.fade));
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text_App(
                        string: "Remember the password ?",
                        Shadow_Text: false,
                        color: Colors.grey,
                        bold: true,
                        size: 15),
                    TextButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            PageTransition(
                                child: User_login(),
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.fade));
                      },
                      child: Text_App(
                          string: "Log in",
                          size: 13,
                          bold: true,
                          color: Color.fromARGB(255, 1, 137, 121)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
