import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BILL/bill_main.dart';
import 'labitem.dart';

class TestPage extends StatefulWidget {
  final String uid;
  final String patientname;
  final String Patient_ID;

  // receive data from the FirstScreen as a parameter
  const TestPage({
    required this.uid,
    required this.patientname,
    required this.Patient_ID,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool valuefirst = false;
  var a = [false, false, false, false, false, false, false, false, false];
  int i = 0;
  @override
  void initState() {
    super.initState();
    for (var j = 0; j < 1000; j++) {
      a.add(false);
    }
  }

  var query = "  ";

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Card(
                // color: Colors.red,
                child: TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: "select test..."),
          onChanged: (val) {
            setState(() {
              query = val;
            });
          },
        ))),
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
                  builder: (context) => bill_mainpage(
                        uid: widget.uid,
                        patientname: widget.patientname,
                        Patient_ID: widget.Patient_ID,
                      )));
            },
            child: Text('NEXT'),
          ),
        ),
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
                flex: 1,
                child: Checkbox(
                  checkColor: Colors.greenAccent,
                  activeColor: Colors.red,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  value: a[user.INDEX],
                  onChanged: (bool? value) {
                    setState(() {
                      print("changed");
                      print(this.a[i]);
                      this.a[user.INDEX] = value!;
                      print(this.a[user.INDEX]);
                      print(user.name);

                      var a = {
                        "id": user.id,
                        "name": user.name,
                        "rate": user.ratee
                      };

                      if (value == true) {
                        FirebaseFirestore.instance
                            .collection('Customers')
                            .doc(widget.uid)
                            .collection("PATIENTS")
                            .doc(widget.Patient_ID)
                            .collection("test")
                            .doc('${user.id}')
                            .set(a);
                      } else {
                        FirebaseFirestore.instance
                            .collection('Customers')
                            .doc(widget.uid)
                            .collection("PATIENTS")
                            .doc(widget.Patient_ID)
                            .collection("test")
                            .doc('${user.id}')
                            .delete();
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rate: ${user.ratee}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "MRP: ${user.Mrp}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Stream<List<Products>> readUsers() => FirebaseFirestore.instance
      .collection("lab")
      // .where("name",
      //     isGreaterThanOrEqualTo: query, isLessThan: query + '\uf8ff')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());
}
