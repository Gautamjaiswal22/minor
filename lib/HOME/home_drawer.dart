import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab/Patients/Patients.dart';
import 'package:lab/payment.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lab/account_profile.dart';
import 'package:lab/phone.dart';
import 'package:lab/addpatient.dart';
import 'package:lab/account_deatils_fun.dart';
// import 'home_body.dart';
import 'package:lab/pricelist.dart';

class Home_Drawer extends StatefulWidget {
  final String uid;
  const Home_Drawer({super.key, required this.uid});

  @override
  State<Home_Drawer> createState() => Home_DrawerState();
}

class Home_DrawerState extends State<Home_Drawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  String accountName = "";
  String accountMail = "";
  String accountMobile = "";

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

  @override
  void initState() {
    super.initState();
    getAccountName();
    setState(() {});
  }

  void getAccountName() async {
    var account = await get_account(widget.uid);
    setState(() {
      accountName = account[1];
      accountMail = account[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 105, 140, 237),
              ),
              accountName: Text(
                accountName.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(accountMail.toString()),
              currentAccountPictureSize: Size.square(40),
              currentAccountPicture: CircleAvatar(
                maxRadius: 30,
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  accountName.toUpperCase(),
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('PATIENTS'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PatientsPage(
                        uid: widget.uid,
                      )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('PRICE LIST'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PricePage(
                        uid: widget.uid,
                      )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Add Patient'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => addpatient(
                        uid: widget.uid,
                      )));
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
            leading: const Icon(Icons.done),
            title: const Text('payment'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => payPage()));
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyPhone()));
            },
          ),
        ],
      ),
    );
  }
}
