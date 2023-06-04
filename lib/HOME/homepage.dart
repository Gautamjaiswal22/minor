import 'package:flutter/material.dart';
import 'package:lab/HOME/home_drawer.dart';
import 'package:lab/HOME/home_navbar.dart';
import 'package:lab/account_profile.dart';
import 'package:lab/account_deatils_fun.dart';
import 'home_body.dart';

class MyHomePage extends StatefulWidget {
  final String uid;
  const MyHomePage({super.key, required this.uid});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pathology Lab'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(uid: widget.uid)));
              var account = await get_account(widget.uid);
              print("account name");
              print(widget.uid);

              // method to show the search bar
              // Navigator.of(context).push(MaterialPageRoute(
              // builder: (context) => CloudFirestoreSearch()));
            },
            icon: const Icon(Icons.account_circle_sharp),
          )
        ],
      ),
      drawer: Home_Drawer(uid: widget.uid),
      bottomNavigationBar: Home_Navbar(uid: widget.uid),
      body: Home_Body(uid: widget.uid),
    );
  }
}
