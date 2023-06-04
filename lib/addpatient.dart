import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lab.dart';
import 'patient_ID.dart';

class addpatient extends StatefulWidget {
  final String uid;
  const addpatient({required this.uid});

  @override
  State<addpatient> createState() => _addpatientState();
}

class _addpatientState extends State<addpatient> {
  String NameController = '';
  String IDController = "";
  String AgeController = "";
  String MobileController = "";
  String AddressController = "";
  String? gender; //no radio button will be selected on initial
  var patient_id = generatePatientId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD PATIENT'),
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
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                onChanged: (text) {
                                  NameController = text;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  hintText: 'ENTER NAME',
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                onChanged: (text) {
                                  AgeController = text;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'AGE ',
                                  hintText: 'Enter AGE',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(1),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Text("Male"),
                                      value: "male",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text("Female"),
                                      value: "female",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text("Other"),
                                      value: "other",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                onChanged: (text) {
                                  MobileController = text;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'MOBILE NO',
                                  hintText: 'Enter MOBILE NO',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: TextField(
                                onChanged: (text) {
                                  AddressController = text;
                                },
                                decoration: InputDecoration(
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
                                var a = {
                                  "Mobile": MobileController,
                                  "age": AgeController,
                                  "name": NameController,
                                  "address": AddressController,
                                  "gender": gender,
                                  "time": Timestamp.now(),
                                };

                                FirebaseFirestore.instance
                                    .collection('Customers')
                                    .doc(widget.uid)
                                    .collection("PATIENTS")
                                    .doc(patient_id)
                                    .set(a);

                                print(widget.uid);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TestPage(
                                          uid: widget.uid,
                                          patientname: NameController,
                                          Patient_ID: patient_id,
                                        )));
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
