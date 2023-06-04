import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab/lab.dart';
import 'package:lab/verify.dart';
import 'package:lab/ds/bill_ds.dart';
import 'package:lab/HOME/homepage.dart';
import 'package:lab/payment.dart';
import 'package:lab/paymentconfirm.dart';
import 'package:lab/bill_functions.dart';

class billAddresspage extends StatefulWidget {
  final String uid;
  final String patientname;
  billAddresspage({required this.uid, required this.patientname});

  @override
  _billAddresspageState createState() => _billAddresspageState();
}

class _billAddresspageState extends State<billAddresspage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      // controller: controller,
      child: StreamBuilder<List<Products>>(
          stream: readAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went Wrong ${snapshot.error}");
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                  shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  children: users.map(buildAdd).toList());
              // return Text("data found");
            } else {
              // return Text(" data not found");
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget buildAdd(Products user) => Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "PATIENT DETAILS",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Patient name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            user.name.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "age :" + user.age.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            user.address.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            user.Mobile.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            user.gender.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      );

  Stream<List<Products>> readAddress() => FirebaseFirestore.instance
      .collection('Customers')
      .doc(widget.uid)
      .collection("PATIENTS")
      .where("name", isEqualTo: widget.patientname)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());
}
