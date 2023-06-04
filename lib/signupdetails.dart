import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab/HOME/homepage.dart';

class signupdata extends StatefulWidget {
  final String uid;
  const signupdata({super.key, required this.uid});

  @override
  State<signupdata> createState() => _signupdataState();
}

class _signupdataState extends State<signupdata> {
  String NameController = '';
  String IDController = "";
  String EmailController = "";
  String MobileController = "";
  String AddressController = "";
  String? gender; //no radio button will be selected on initial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN UP'),
        backgroundColor: const Color.fromARGB(235, 221, 2, 2),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Color.fromARGB(255, 98, 100, 102),
          height: 700,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                color: const Color.fromARGB(255, 247, 249, 247),
                height: 700.0,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextField(
                                // controller: nameController,
                                onChanged: (text) {
                                  NameController = text;
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  hintText: 'ENTER NAME',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextField(
                                // controller: RATEController,
                                onChanged: (text) {
                                  MobileController = text;
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.call),
                                  border: OutlineInputBorder(),
                                  labelText: 'Mobile No ',
                                  hintText: 'Enter Mobile No',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextField(
                                // controller: MRPController,
                                onChanged: (text) {
                                  EmailController = text;
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.alternate_email_sharp),
                                  border: OutlineInputBorder(),
                                  labelText: 'Mail ID',
                                  hintText: 'Enter Mail ID',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextField(
                                // controller: MIDController,
                                onChanged: (text) {
                                  AddressController = text;
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.place),
                                  border: OutlineInputBorder(),
                                  labelText: 'Address',
                                  hintText: 'Enter Address',
                                ),
                              ),
                            ),
                            ElevatedButton(
                              // textColor: Colors.white,
                              // color: Colors.blue,
                              child: const Text('SUBMIT'),
                              onPressed: () {
                                var a = {
                                  "Mobile": MobileController,
                                  "Email": EmailController,
                                  "name": NameController,
                                  "address": AddressController,
                                  "ID": widget.uid
                                };
                                FirebaseFirestore.instance
                                    .collection('Customers')
                                    .doc(widget.uid)
                                    .set(a);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(uid: widget.uid)));
                              },
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
