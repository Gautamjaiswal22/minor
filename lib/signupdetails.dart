import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lab.dart';
import 'homepage.dart';

class signupdata extends StatefulWidget {
  final String userid;
  const signupdata({super.key, required this.userid});

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
        title: Text('SIGN UP'),
        backgroundColor: Color.fromARGB(235, 221, 2, 2),
      ),
      body: SingleChildScrollView(
        child: new Container(
          // color: Color.fromARGB(255, 98, 100, 102),
          height: 700,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                color: Color.fromARGB(255, 247, 249, 247),
                height: 700.0,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: TextField(
                                // controller: nameController,
                                onChanged: (text) {
                                  NameController = text;
                                },
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  hintText: 'ENTER NAME',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: TextField(
                                // controller: RATEController,
                                onChanged: (text) {
                                  MobileController = text;
                                },
                                decoration: InputDecoration(
                                  icon: Icon(Icons.call),
                                  border: OutlineInputBorder(),
                                  labelText: 'Mobile No ',
                                  hintText: 'Enter Mobile No',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            // Padding(
                            //     padding: EdgeInsets.all(15),
                            //     child: Column(
                            //       children: [
                            //         RadioListTile(
                            //           title: Text("Male"),
                            //           value: "male",
                            //           groupValue: gender,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               gender = value.toString();
                            //             });
                            //           },
                            //         ),
                            //         RadioListTile(
                            //           title: Text("Female"),
                            //           value: "female",
                            //           groupValue: gender,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               gender = value.toString();
                            //             });
                            //           },
                            //         ),
                            //         RadioListTile(
                            //           title: Text("Other"),
                            //           value: "other",
                            //           groupValue: gender,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               gender = value.toString();
                            //             });
                            //           },
                            //         )
                            //       ],
                            //     )),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: TextField(
                                // controller: MRPController,
                                onChanged: (text) {
                                  EmailController = text;
                                },
                                decoration: InputDecoration(
                                  icon: Icon(Icons.alternate_email_sharp),
                                  border: OutlineInputBorder(),
                                  labelText: 'Mail ID',
                                  hintText: 'Enter Mail ID',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: TextField(
                                // controller: MIDController,
                                onChanged: (text) {
                                  AddressController = text;
                                },
                                decoration: InputDecoration(
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
                              child: Text('SUBMIT'),
                              onPressed: () {
                                // List lstname = [];
                                // for (int i = 1; i <= val.length; i++) {
                                //   lstname.add(val.substring(0, i));
                                // }
                                var a = {
                                  "Mobile": MobileController,
                                  "Email": EmailController,
                                  "name": NameController,
                                  "address": AddressController,
                                };
                                FirebaseFirestore.instance
                                    .collection('Customers')
                                    .doc(widget.userid)
                                    // .collection("${NameController}")
                                    // .doc("detail")
                                    .set(a);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                        NameController: NameController)));
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
