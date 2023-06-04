import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double speed;
  final double pause;

  AnimatedText(
      {required this.text,
      required this.style,
      this.speed = 50,
      this.pause = 1000});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String _displayText = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() async {
    for (int i = 0; i < widget.text.length; i++) {
      await Future.delayed(Duration(milliseconds: (widget.speed).round()));
      setState(() {
        _displayText = widget.text.substring(0, _index) + '|';
        if (_index < widget.text.length) {
          _index++;
        }
      });
    }
    await Future.delayed(Duration(milliseconds: (widget.pause).round()));
    setState(() {
      _displayText = widget.text;
      _index = 0;
    });
    _animateText();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style,
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "PATHOLINK",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              child: Center(
                child: AnimatedText(
                  text: "Empowering Small Hospitals with Pathology Services",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  speed: 50,
                  pause: 1000,
                ),
              ),
            ),
            Container(
              height: 110,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Our pathology application, PathoLink, is designed to empower small hospitals by providing them with comprehensive pathology services. Our easy-to-use application makes it simple for medical professionals to submit and track pathology samples, receive test results, and communicate with our team of experienced pathologists. With our user-friendly interface and location-based services, we make it easy for small hospitals to access the pathology services they need. PathoLink is committed to providing high-quality pathology services to our clients, so they can focus on providing the best care possible to their patients.",
                    textStyle: TextStyle(
                      fontSize: 10,
                    ),
                    speed: Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                pause: Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'Name: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Gautam Jaiswal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,

                      // color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'Email: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'support@pathologylab.com',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.email),
              label: Text("Send us an email"),
              onPressed: () async {
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'example@example.com',
                  query: 'subject=Example Subject&body=Example Body',
                );
                String url = params.toString();
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Phone: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '+91-7999973953',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.phone),
              label: Text("Call Now"),
              onPressed: () async {
                const phoneNumber = 'tel:+91799973953';
                if (await canLaunch(phoneNumber)) {
                  await launch(phoneNumber);
                } else {
                  throw 'Could not launch $phoneNumber';
                }
              },
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Address: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '123 Main Street,\nCity, State, Zip Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Open Map"),
              onPressed: () async {
                final url =
                    'https://www.google.com/maps/search/?api=1&query=1234+Main+Street+City+State';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch map';
                }
              },
            ),
            SizedBox(height: 10),
            Center(
              child: AnimatedText(
                text: "Empowering Pathology Services at Your Fingertips",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                speed: 80,
                pause: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
