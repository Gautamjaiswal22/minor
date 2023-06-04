import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String address = "";
  String mobile = "";

  @override
  void initState() {
    super.initState();
    getAccount();
  }

  void getAccount() async {
    var collection = FirebaseFirestore.instance
        .collection('Customers')
        .where('ID', isEqualTo: widget.uid);
    var uidname = await collection.get();
    for (var queryDocumentSnapshot in uidname.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      setState(() {
        name = data['name'];
        email = data['Email'];
        address = data['address'];
        mobile = data['Mobile'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement edit functionality
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 4,
              backgroundImage: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/lab-acdd6.appspot.com/o/IMG-20230129-WA0006%20copy2.jpg?alt=media&token=c4494bd6-4d28-489a-9980-047ca0c04870',
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              address,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              mobile,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
