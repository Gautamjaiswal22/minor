// // main.dart
import 'package:flutter/material.dart';
import 'labitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PricePageSearch extends StatefulWidget {
  const PricePageSearch({
    super.key,
  });

  @override
  State<PricePageSearch> createState() => _PricePageSearchState();
}

class _PricePageSearchState extends State<PricePageSearch> {
  var query = "";
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
          )),
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
                            "Price: ${user.ratee}",
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
      .where("name", isGreaterThanOrEqualTo: query.toLowerCase())
      .where("name", isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Products.fromJson(doc.data())).toList());
}
