import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'phone.dart';
import 'verify.dart';
import 'package:lab/HOME/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var islogin = false;

  checkifLogin() async {
    auth.authStateChanges().listen((User? User) {
      if (User != null && mounted) {
        setState(() {
          islogin = true;
          print('islogin');
          print(islogin);
          print("is log in main page uid ");
          final uid = uidData();
          // print(uid);
        });
      }
    });
  }

  @override
  void initState() {
    checkifLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PATHOLAB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: islogin ? MyHomePage(uid: uidData()) : MyPhone(),
    );
  }
}
