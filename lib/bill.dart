import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab/lab.dart';
import 'package:lab/verify.dart';
import 'ds/bill_ds.dart';
import 'package:lab/HOME/homepage.dart';
import 'payment.dart';
import 'paymentconfirm.dart';
import 'bill_functions.dart';

class billpage extends StatefulWidget {
  final String uid;
  final String patientname;
  billpage({required this.uid, required this.patientname});

  @override
  _billpageState createState() => _billpageState();
}

class _billpageState extends State<billpage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("BILLING"),
        ),
        body: SingleChildScrollView(
          child: new Container(
            // color: Color.fromARGB(255, 98, 100, 102),
            height: 500.0,
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  // color: Color.fromARGB(255, 66, 11, 11),
                  height: 145.0,
                  // alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      // Container(
                      //     child: SizedBox(
                      //   height: 20,
                      // )),
                      Container(
                        height: 145,
                        // controller: controller,
                        child: StreamBuilder<List<Products>>(
                            stream: readAddress(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Something went Wrong ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final users = snapshot.data!;
                                return ListView(
                                    shrinkWrap: false,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: users.map(buildAdd).toList());
                                // return Text("data found");
                              } else {
                                // return Text(" data not found");
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                //------------------------------list------

                Container(
                  // color: Color.fromARGB(255, 220, 9, 9),
                  height: 350.0,
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'TEST DESCRIPTION ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 11, 4, 4)),
                        ),
                      ),
                      Container(
                        child: Table(
                          defaultColumnWidth: FixedColumnWidth(115.0),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          children: [
                            TableRow(children: [
                              Column(children: [
                                Text('NAME',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                              Column(children: [
                                Text('RATE',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                              Column(children: [
                                Text('TOTAL',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                            ]),
                          ],
                        ),
                        // child: ListView(shrinkWrap: true,
                        //     // scrollDirection: Axis.horizontal,
                        //     children: <Widget>[
                        //   ListTile(
                        //     title: Text(
                        //         'S.No   Product Name     Rate     Total',
                        //         style: TextStyle(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold)),
                        //   ),
                        // ])
                      ),
                      Container(
                        height: 200,
                        color: Color.fromARGB(255, 251, 251, 251),
                        // controller: controller,
                        child: StreamBuilder<List<test>>(
                            stream: readUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Something went Wrong ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final users = snapshot.data!;
                                return ListView(
                                    shrinkWrap: true,
                                    children: users.map(buildUser).toList());
                                // return Text("data found");
                              } else {
                                // return Text(" data not found");
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      Container(
                        height: 50,
                        color: Color.fromARGB(255, 251, 251, 251),
                        child: FutureBuilder(
                          future: getTotal(widget.patientname, "pt665694"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  "Something went wrong: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              return Text("Total : ${snapshot.data}");
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   // color: Color.fromARGB(255, 175, 9, 9),
                //   height: 80.0,
                //   alignment: Alignment.center,
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: FlatButton(
                //           child: Text(
                //             'CONTINUE TO PAYMENT',
                //             style: TextStyle(fontSize: 20.0),
                //           ),
                //           color: Color.fromARGB(255, 0, 206, 34),
                //           textColor: Colors.white,
                //           onPressed: () {
                //             print("button");
                //             getDETAIL();
                //             Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (context) => MyHomePage()));
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => PaymentConfirmedScreen()));

              afterPayment(widget.patientname, "pt230288988898");
              getTotal(widget.patientname, "pt230288988898");
            },
            // color: Color.fromARGB(255, 97, 217, 27),
            // textColor: Colors.white,
            child: Text('CONTINUE TO PAYMENT'),
          ),
        ),
      ),
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
      .collection(widget.patientname)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());

  Widget buildUser(test user) => Card(
        color: Color.fromRGBO(255, 255, 255, 1),
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          padding: EdgeInsets.all(1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                // padding: EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1),
                            children: [
                              // TableRow(children: [
                              //   Column(children: [
                              //     Text('Website',
                              //         style: TextStyle(fontSize: 20.0))
                              //   ]),
                              //   Column(children: [
                              //     Text('Tutorial',
                              //         style: TextStyle(fontSize: 20.0))
                              //   ]),
                              //   Column(children: [
                              //     Text('Review',
                              //         style: TextStyle(fontSize: 20.0))
                              //   ]),
                              // ]),
                              TableRow(children: [
                                Column(children: [Text(user.name.toString())]),
                                Column(children: [Text(user.rate.toString())]),
                                Column(children: [Text('5')]),
                              ]),
                            ],
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

  Stream<List<test>> readUsers() => FirebaseFirestore.instance
      .collection('Customers')
      .doc(widget.uid)
      .collection(widget.patientname)
      .doc("detail")
      .collection("test")
      //.where('name', isEqualTo: "PARACETAMOL")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => test.fromJson(doc.data())).toList());

  //-------------total card start-------------------------
  Widget buildtotal(Products user) => Card(
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
                // padding: EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "TOTAL",
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
                            "g",
                            // getTotal.toString(),
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

  // -----------------total card end------------------------

  //-------------------------------------update to admin---
}
