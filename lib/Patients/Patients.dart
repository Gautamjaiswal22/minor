import 'package:flutter/material.dart';
import 'Patients_ds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientsPage extends StatefulWidget {
  final String uid;
  const PatientsPage({super.key, required this.uid});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Patients "),
        ),
        body: StreamBuilder<List<Products>>(
            stream: readUsers(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.hasError) {
                return Text("Something went Wrong ${snapshot.error}");
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(children: users.map(buildUser).toList());
                // return Text("data found");
              } else {
                // return Text(" data not found");
                return Center(child: CircularProgressIndicator());
              }
            }),
      );

  Widget buildUser(Products user) => Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "ID : " + user.ID.toString(),
                      //   style: TextStyle(
                      //       fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(height: 8),
                      Text(
                        "NAME :" + user.name.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "MOBILE :" + user.Mobile.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "GENDER :" + user.gender.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "ADDRESS :" + user.address.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Stream<List<Products>> readUsers() => FirebaseFirestore.instance
      .collection("Customers")
      .doc(widget.uid)
      .collection("PATIENTS")
      .orderBy("time", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());
}
