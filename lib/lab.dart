// // main.dart
import 'package:flutter/material.dart';
import 'labitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'bill.dart';

class TestPage extends StatefulWidget {
  final String NameController;

  // receive data from the FirstScreen as a parameter
  // TestPage({Key key, @required this.text}) : super(key: key);
  const TestPage({super.key, required this.NameController});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // final controller = TextEditingController();
  bool valuefirst = false;
  var a = [false, false, false, false, false, false, false, false, false];
  int i = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Available Test "),
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      billpage(transModel: widget.NameController)));
            },
            child: Text('NEXT'),
          ),
        ),
      );

  Widget buildUser(Products user) => Card(
        // var val=10;
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                user.name.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                user.ratee.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                user.ratee.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Checkbox(
                                checkColor: Colors.greenAccent,
                                activeColor: Colors.red,
                                value: a[user.INDEX],
                                onChanged: (bool? value) => {
                                  setState(() {
                                    print("chnaged");

                                    print(this.a[i]);
                                    this.a[user.INDEX] = value!;
                                    print(this.a[user.INDEX]);
                                    // i++;
                                    // valuefirst = value!;
                                    // user.box = valuefirst;
                                    // final docuser = FirebaseFirestore.instance
                                    //     .collection('lab')
                                    //     .doc('${user.id}');
                                    // docuser.update({
                                    //   'check': value,
                                    // });
                                    var a = {
                                      "id": user.id,
                                      "name": user.name,
                                      "rate": user.ratee
                                    };
                                    // print(widget.NameController);
                                    if (value == true) {
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc("jaiswal")
                                          .collection(widget.NameController)
                                          .doc("detail")
                                          .collection("test")
                                          .doc('${user.id}')
                                          .set(a);
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc("jaiswal")
                                          .collection(widget.NameController)
                                          .doc("detail")
                                          .collection("test")
                                          .doc('${user.id}')
                                          .delete();
                                    }
                                    print(
                                        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                    // print(user.box);
                                    // print(readUsers());
                                    // this.valuefirst = false;
                                    // FirebaseFirestore.instance
                                    //     .collection('user')
                                    //     .doc("jaiswal")
                                    //     .collection("patient1")
                                    //     .doc("detail")
                                    //     .collection("test")
                                    //     .doc('${user.id}')
                                    //     .delete();
                                  }),
                                },
                              ),
                            ),
                          ])),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      );

  Stream<List<Products>> readUsers() =>
      FirebaseFirestore.instance.collection("lab").snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());
}
