import 'package:flutter/material.dart';
import 'package:lab/HOME/homepage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: QrImage(
          data: 'This is a QR code!',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyHomePage(
                      uid: "uid",
                    )));
          },
          child: Text('CONTINUE TO HOME'),
        ),
      ),
    );
  }
}
