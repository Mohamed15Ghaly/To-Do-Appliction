import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_appliction/user_sign/user_login.dart';
import '../components/constants.dart';

class User_Sign_Up extends StatefulWidget {
  @override
  State<User_Sign_Up> createState() => _User_Sign_UpState();
}

class _User_Sign_UpState extends State<User_Sign_Up> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  TextEditingController UserName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Confirm_Password = TextEditingController();
  bool _Switch1 = true, _Switch2 = true, agree = false;

  @override
  void dispose() {
    UserName;
    Email;
    Password;
    Confirm_Password;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Column(
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
                              color: const Color.fromARGB(255, 1, 137, 121),
                              string: "Create an account",
                              bold: true,
                              size: 25),
                          Gap(5),
                          Text_App(
                              string: "Connect with your friends today!",
                              Shadow_Text: false,
                              color: Colors.grey,
                              bold: true,
                              size: 15),

                          Gap(25),
                          Form(
                              key: _formKey2,
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
                                      prefix: Icons.lock,
                                      Switch: _Switch1,
                                      suffix: _Switch1
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      suffixOnpressed: () {
                                        setState(() {
                                          _Switch1 = !_Switch1;
                                        });
                                      }),
                                  Gap(15),
                                  defaultTextFormfield(
                                    LabelHint: "Confirm password",
                                      Type: TextInputType.visiblePassword,
                                      Control: Confirm_Password,
                                      prefix: Icons.lock,
                                      Switch: _Switch2,
                                      suffix: _Switch2
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      suffixOnpressed: () {
                                        setState(() {
                                          _Switch2 = !_Switch2;
                                        });
                                      }),
                                  Gap(5),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: .85,
                                        child: Checkbox(
                                          value: agree,
                                          onChanged: (value) {
                                            setState(() {
                                              agree = !agree;
                                            });
                                          },
                                          checkColor: Colors.white,
                                          activeColor:
                                              Color.fromARGB(255, 1, 137, 121),
                                          side: BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 1, 137, 121)),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                      Text_App(
                                          string:
                                              "I agree to the terms and conditions ",
                                          size: 13,
                                          bold: true,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ],
                              )),
                          Gap(20),
                          defaultMaterialButtom(
                              Width: MediaQuery.sizeOf(context).width,
                              string: "Sign Up",
                              What_Fundction_do: () async {
                                if (Confirm_Password.text.isEmpty ||
                                    Password.text.isEmpty ||
                                    Email.text.isEmpty)
                                  defaultFlusbar(
                                          message: "You must fill fields",
                                          Second: 3,
                                          icon: Icons.warning_amber,
                                          Title: "Sign up failed")
                                      .show(context);
                                else if (Confirm_Password.text != Password.text)
                                  defaultFlusbar(
                                          message:
                                              "You must verify the password",
                                          Second: 3,
                                          icon: Icons.warning_amber,
                                          Title: "Password error")
                                      .show(context);
                                else if (!agree)
                                  defaultFlusbar(
                                          message:
                                              "You must agree to the terms and conditions ",
                                          Second: 3,
                                          icon: Icons.warning_amber,
                                          Title: "Terms and conditions")
                                      .show(context);
                                else if (_formKey2.currentState!.validate()) {
                                  defaultFlusbar(
                                      message:
                                          "You must send Email Verification",
                                      Second: 180,
                                      Title: "Email Verification",
                                      icon: Icons.info_outline,
                                      buttom: true,
                                      icon_do: () async {
                                        try {
                                          final User = await FirebaseAuth
                                              .instance
                                              .createUserWithEmailAndPassword(
                                            email: Email.text.trim(),
                                            password: Password.text.trim(),
                                          );
                                          FirebaseAuth.instance.currentUser!
                                              .sendEmailVerification();
                                          await Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  child: User_login(),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  type:
                                                      PageTransitionType.fade));
                                        } on FirebaseAuthException catch (e) {
                                          String error = "";
                                          if (e.code == 'weak-password')
                                            error =
                                                "The password provided is too weak";
                                          else if (e.code ==
                                              'email-already-in-use')
                                            error =
                                                "The account already exists for that email";
                                          else
                                            error =
                                                "please complete the information below";
                                          defaultFlusbar(
                                                  message: error,
                                                  Title: "Login failed",
                                                  icon: Icons.warning_amber,
                                                  Second: 3)
                                              .show(context);
                                        }
                                      }).show(context);
                                }
                              }),
                          defaultQuestion(onpressed: () async{
                            await Navigator.push(
                                context,
                                PageTransition(
                                    child: User_login(),
                                    duration: Duration(
                                        milliseconds: 500),
                                    type:
                                    PageTransitionType.fade)
                            );
                          }, Question: "Already have an account ?", Answer: "Log in"),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      );
  }
}
