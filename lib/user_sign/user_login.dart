import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_appliction/mission/mission.dart';
import 'package:todo_appliction/user_sign/forget_pass.dart';
import 'package:todo_appliction/user_sign/user_sign_up.dart';
import '../components/constants.dart';

class User_login extends StatefulWidget {
  @override
  State<User_login> createState() => _User_loginState();
}

class _User_loginState extends State<User_login> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool _Switch = false , isloading = false;

  @override
  void dispose() {
    Email;
    Password;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:  Column(
                  children: [
                    Image.asset("assets/signin_balls.png"),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text_App(
                                  string: "Hi, Welcome Back!",
                                  bold: true,
                                  size: 25,
                                  color: Color.fromARGB(255, 1, 137, 121),
                                ),
                                Gap(5),
                                Text_App(
                                    string: "Hello again, you’ve been missed!",
                                    Shadow_Text: false,
                                    color: Colors.grey,
                                    bold: true,
                                    size: 15),
                                Gap(35),
                                Form(
                                    key: _formKey1,
                                    child: Column(
                                      children: [
                                        defaultTextFormfield(
                                          LabelHint: "Email address",
                                          Control: Email,
                                          Type: TextInputType.emailAddress,
                                          prefix: Icons.email_rounded,
                                        ),
                                        Gap(15),
                                        defaultTextFormfield(
                                          LabelHint: "Password",
                                            Type: TextInputType.visiblePassword,
                                            Control: Password,
                                            Switch: _Switch,
                                            prefix: Icons.lock,
                                            suffix: _Switch
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            suffixOnpressed: () {
                                              setState(() {
                                                _Switch = !_Switch;
                                              });
                                            }),
                                        Gap(5),
                                      ],
                                    )),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: User_Forget_Pass(),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  type:
                                                      PageTransitionType.fade)
                                          );
                                        },
                                        child: Text_App(
                                            string: "Forgot Password ?",
                                            size: 13,
                                            bold: true,
                                            color: Colors.grey),
                                      )
                                    ]),
                                defaultMaterialButtom(
                                  loading: isloading,
                                    Loading: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,

                                          ),
                                        ),
                                        Gap(25),
                                        Text("Please Wait ..." ,style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),)
                                      ],
                                    ),
                                    Width: MediaQuery.sizeOf(context).width,
                                    string: "Log in",
                                    What_Fundction_do: () async {
                                      String? error;
                                      if (Email.text.isEmpty ||
                                          Password.text.isEmpty) {
                                        error = "You must fill fields";
                                        defaultFlusbar(
                                                message: error,
                                                Title: "Login failed",
                                                icon: Icons.warning_amber,
                                                Second: 3)
                                            .show(context);
                                      }
                                      else if (_formKey1.currentState!
                                          .validate()) {
                                        try {
                                          final User = await FirebaseAuth
                                              .instance
                                              .signInWithEmailAndPassword(
                                                  email: Email.text.trim(),
                                                  password:
                                                      Password.text.trim());
                                          setState(() {
                                            isloading = true;
                                          });
                                          await Future.delayed(Duration(milliseconds: 2500));
                                          await Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  child: Mission(),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  type:
                                                      PageTransitionType.fade));
                                          setState(() {
                                            isloading = false;
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          error = "Incorrect email or password";
                                          defaultFlusbar(
                                                  message: error,
                                                  Title: "Login failed",
                                                  icon: Icons.warning_amber,
                                                  Second: 3)
                                              .show(context);
                                        }
                                      }
                                    }),
                                defaultQuestion(onpressed: () async {
                                  await Navigator.push(
                                      context,
                                      PageTransition(
                                          child: User_Sign_Up(),
                                          duration:
                                          Duration(milliseconds: 500),
                                          type: PageTransitionType.fade));
                                }, Question: "Don’t have an account ?", Answer: "Sign Up"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
