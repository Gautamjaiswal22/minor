import 'package:flutter/material.dart';
import 'package:lab/BILL/bill1_address.dart';
import 'package:lab/BILL/bill2_.dart';
import 'package:lab/paymentconfirm.dart';
import 'package:lab/bill_functions.dart';

class bill_mainpage extends StatefulWidget {
  final String uid;
  final String patientname;
  final String Patient_ID;

  bill_mainpage({
    required this.uid,
    required this.patientname,
    required this.Patient_ID,
  });

  @override
  _bill_mainpageState createState() => _bill_mainpageState();
}

class _bill_mainpageState extends State<bill_mainpage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return new MaterialApp(
    // home: new Scaffold(
    return Scaffold(
      appBar: AppBar(
        title: Text("BILLING"),
      ),
      body: SingleChildScrollView(
        child: new Container(
          // color: Color.fromARGB(255, 98, 100, 102),
          height: 700.0,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              billAddresspage(uid: widget.uid, patientname: widget.patientname),
              bill_itemspage(
                uid: widget.uid,
                patientname: widget.patientname,
                Patient_ID: widget.Patient_ID,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            var ch = await afterPayment(widget.patientname, widget.Patient_ID);

            if (await afterPayment(widget.patientname, widget.Patient_ID) ==
                1) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentConfirmedScreen()));
            }
          },
          // color: Color.fromARGB(255, 97, 217, 27),
          // textColor: Colors.white,
          child: Text('CONTINUE TO PAYMENT'),
        ),
      ),
      // ),
    );
  }
}
