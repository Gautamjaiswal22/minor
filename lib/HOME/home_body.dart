import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab/REPORT/report.dart';
// import 'package:lab/account_profile.dart';
// import 'package:lab/paymentconfirm.dart';
// import 'package:lab/phone.dart';
import 'package:lab/addpatient.dart';
import 'package:lab/pricelist.dart';
import 'package:lab/contactus.dart';
import 'package:lab/aboutus.dart';
// import 'package:lab/qr.dart';
// import 'package:lab/account_deatils_fun.dart';
import 'package:lab/REPORT/report.dart';

class Home_Body extends StatefulWidget {
  final String uid;
  const Home_Body({super.key, required this.uid});

  @override
  State<Home_Body> createState() => _Home_BodyState();
}

class _Home_BodyState extends State<Home_Body> {
  double iconsize = 80;
  int _currentIndex = 0;
  String accountName = "";
  String accountMail = "";
  String accountMobile = "";

  final List<String> _images = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentIndex < _images.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              _images[_currentIndex],
              fit: BoxFit.cover,
              // fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => addpatient(
                              uid: widget.uid,
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: iconsize,
                      ),
                      SizedBox(
                          width:
                              120.0), // Add some space between the icon and text
                      Text('Add Patient'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10, // Set the button elevation
                    shadowColor: Color.fromARGB(255, 58, 57, 57)
                        .withOpacity(1), // Set the shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the button border radius
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReportPage(
                              uid: widget.uid,
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: iconsize,
                      ),
                      SizedBox(
                          width:
                              120.0), // Add some space between the icon and text
                      Text('Results'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10, // Set the button elevation
                    shadowColor: Color.fromARGB(255, 58, 57, 57)
                        .withOpacity(1), // Set the shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the button border radius
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutUsPage()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_rounded,
                        size: iconsize,
                      ),
                      SizedBox(
                          width:
                              120.0), // Add some space between the icon and text
                      Text('About Us'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10, // Set the button elevation
                    shadowColor: Color.fromARGB(255, 58, 57, 57)
                        .withOpacity(1), // Set the shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the button border radius
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => PaymentConfirmedScreen()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital_outlined,
                        size: iconsize,
                      ),
                      SizedBox(
                          width:
                              120.0), // Add some space between the icon and text
                      Text('Center near me'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10, // Set the button elevation
                    shadowColor: Color.fromARGB(255, 58, 57, 57)
                        .withOpacity(1), // Set the shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the button border radius
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ContactUsPage()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        size: iconsize,
                      ),
                      SizedBox(
                          width:
                              120.0), // Add some space between the icon and text
                      Text('contact Us'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10, // Set the button elevation
                    shadowColor: Color.fromARGB(255, 58, 57, 57)
                        .withOpacity(1), // Set the shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the button border radius
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PricePage(
                              uid: widget.uid,
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: iconsize,
                      ),
                      SizedBox(
                          width:
                              120.0), // Add some space between the icon and text
                      Text('Price List'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10, // Set the button elevation
                    shadowColor: Color.fromARGB(255, 58, 57, 57)
                        .withOpacity(1), // Set the shadow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the button border radius
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
