import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lab/main.dart';
import 'package:lab/phone.dart';
import 'addpatient.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MEDICINE SHOPPING APPLICATION',
//       //theme: ThemeData(fontFamily: 'FredokaOne'),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         fontFamily: 'Fredoka One',
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  final String NameController;

  // receive data from the FirstScreen as a parameter
  // TestPage({Key key, @required this.text}) : super(key: key);
  const MyHomePage({super.key, required this.NameController});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // static List<Widget> _widgetOptions = <Widget>[
  //   message(),
  //   team(),
  //   addquery(),
  //   time(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _count = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LAB",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: "Fredoka One"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              // Navigator.of(context).push(MaterialPageRoute(
              // builder: (context) => CloudFirestoreSearch()));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => addpatient()));
          },
          tooltip: 'cart',
          child: const Icon(Icons.person_add_alt_1)),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "GAUTAM",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("GAUTAMJAISWAL@gmail.com"),
                currentAccountPictureSize: Size.square(60),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "G",
                    style: TextStyle(fontSize: 50.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('CUSTOMERS '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('PRICE LIST'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Add Patient'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => addpatient()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services_rounded),
              title: const Text('Uncollected Samples'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_note_sharp),
              title: const Text('Collected  Samples'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.watch_later_outlined),
              title: const Text('Pending Result'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.done),
              title: const Text('Completed test'),
              onTap: () {
                // Navigator.of(context)
                // .push(MaterialPageRoute(builder: (context) => addmed()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                // Navigator.pop(context);

                print("log out button current user");
                final User user = auth.currentUser!;
                final uid = user.uid;
                print(uid);
                print("log out button pressed");
                // FirebaseAuth.instance.signOut();
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyPhone()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 191, 181, 209),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notification_important_sharp,
              ),
              // title: Text('Home'),
              label: "Notifications",
              // backgroundColor: Color.fromARGB(255, 204, 7, 7)
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_add_rounded,
              ),
              // title: Text('Search'),
              label: "add patient",
              // backgroundColor: Color.fromARGB(255, 100, 10, 10)
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.medical_services_rounded,
              ),
              // title: Text('Profile'),
              label: "uncollected",
              // backgroundColor: Color(0xFF280A64),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.picture_as_pdf,
              ),
              // title: Text('Profile'),
              label: "Results",
              // backgroundColor: Color(0xFF280A64),
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 237, 2, 2),
          unselectedItemColor: Color.fromARGB(255, 236, 176, 175),
          unselectedFontSize: 14,
          selectedIconTheme:
              IconThemeData(color: Color.fromARGB(255, 235, 3, 3), size: 40),
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 20),
    );
  }
}
