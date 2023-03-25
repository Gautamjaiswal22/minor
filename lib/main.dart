import 'package:flutter/material.dart';
import 'phone.dart';
import 'verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'lab.dart';
import 'addpatient.dart';
import 'homepage.dart';
import 'bill.dart';
import 'signupdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  // runApp(MaterialApp(
  //   initialRoute: 'phone',
  //   debugShowCheckedModeBanner: false,
  //   routes: {
  //     'phone': (context) => MyPhone(),
  //     'verify': (context) => MyVerify(),
  //     'bill': (context) => TestPage(
  //           NameController: "BxGhpJoEC5USC503z0B9xEV1cR62",
  //         ),
  //   },
  // ));
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
      theme: ThemeData(primarySwatch: Colors.red),
      home: islogin ? MyHomePage(NameController: "NameController") : MyPhone(),
    );
  }
}

