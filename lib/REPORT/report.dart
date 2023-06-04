import 'package:flutter/material.dart';
import 'report_ds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'view_report.dart';

class ReportPage extends StatefulWidget {
  final String uid;
  const ReportPage({super.key, required this.uid});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
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
                        "NAME :" + user.PT_name.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      // Text(
                      //   "patient name :" + user.PT_name.toString(),
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //   ),
                      // ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFViewerPage(pdfUrl: user.url),
                              ),
                            )
                          },
                          child: Text("view Report"),
                        ),
                      )
                      // Text(
                      //   "GENDER :" + user.createdAt.toString(),
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Stream<List<Products>> readUsers() => FirebaseFirestore.instance
      .collection("REPORTS")
      .doc(widget.uid)
      .collection("PATIENTS")
      // .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());
}
