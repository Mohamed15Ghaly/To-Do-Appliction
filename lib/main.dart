import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_appliction/loading.dart';
import 'package:todo_appliction/mission/mission.dart';
import 'package:todo_appliction/user_sign/user_login.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 0, 106, 94),
      statusBarIconBrightness: Brightness.light));

  runApp(Todo());
}

class Todo extends StatefulWidget {
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool isLoading = true , remember_me = false;
  User? user = FirebaseAuth.instance.currentUser;
  Loading() async {
    await Future.delayed(Duration(milliseconds: 2500));
    isLoading = !isLoading;
    setState(() {});
  }
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        setState(() {
          remember_me = false;
        });
      } else {
        remember_me = true;
      }
    });
    Loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false, appBarTheme: AppBarTheme()),
        home:isLoading? Loading_Page():remember_me? Mission():User_login());
  }
}
