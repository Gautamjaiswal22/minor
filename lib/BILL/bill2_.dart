
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab/ds/bill_ds.dart';
import 'package:lab/bill_functions.dart';

class bill_itemspage extends StatefulWidget {
  final String uid;
  final String patientname;
  final String Patient_ID;
  bill_itemspage({
    required this.uid,
    required this.patientname,
    required this.Patient_ID,
  });

  @override
  _bill_itemspageState createState() => _bill_itemspageState();
}

class _bill_itemspageState extends State<bill_itemspage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 220, 9, 9),
      height: 300.0,
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
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: [
                    Text('NAME',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold))
                  ]),
                  Column(children: [
                    Text('RATE',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold))
                  ]),
                ]),
              ],
            ),
          ),
          Container(
            height: 200,
            color: Color.fromARGB(255, 251, 251, 251),
            // controller: controller,
            child: StreamBuilder<List<test>>(
                stream: readUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went Wrong ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return ListView(
                        shrinkWrap: true,
                        children: users.map(buildUser).toList());
                    // return Text("data found");
                  } else {
                    // return Text(" data not found");
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Container(
            height: 50,
            color: Color.fromARGB(255, 251, 251, 251),
            child: FutureBuilder(
              future: getTotal(widget.patientname, widget.Patient_ID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Total : ${snapshot.data}        ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

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
                          alignment: Alignment.center,
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1),
                            children: [
                              TableRow(children: [
                                Column(children: [Text(user.name.toString())]),
                                Column(children: [Text(user.rate.toString())]),
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
      .collection("PATIENTS")
      .doc(widget.Patient_ID)
      .collection("test")
      //.where('name', isEqualTo: "PARACETAMOL")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => test.fromJson(doc.data())).toList());
}
