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

class AboutUsPage extends StatelessWidget {
  var background =
      "A visionary entrepreneur with a passion for healthcare recognized the need to bring pathology services to small hospitals and patients right to their doorstep. Seeing the need for affordable and high-quality diagnostic services, the owner envisioned a comprehensive pathology lab that would provide a full range of testing and analysis services to all those who need it. With this goal in mind, the lab was founded with a commitment to provide accurate and timely results, utilizing the latest technology and highly skilled professionals. Today, we are proud to continue this legacy of excellence and innovation, delivering cutting-edge pathology services to our clients and patients.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: new Container(
          height: 1500,
          child: Padding(
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
                      text:
                          "Empowering Small Hospitals with Pathology Services",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      speed: 50,
                      pause: 1000,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Background and History",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Text(background),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Services",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 300,
                  width: 150,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20, // set the height of the first list tile
                        child: ListTile(
                          title: Text('1.Online test booking and scheduling'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('2.Home sample collection'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('3.Lab testing and diagnosis'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('4.Test result tracking and management'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('5.Online payment and billing'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('6.Electronic health records management'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title:
                              Text('7.Doctor consultation and recommendation'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('8.Prescription management and tracking'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('9.Health tips and advice'),
                        ),
                      ),
                      SizedBox(
                        height: 20, // set the height of the second list tile
                        child: ListTile(
                          title: Text('10.24/7 customer support.'),
                        ),
                      ),
                    ],
                  ),
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
                        text: '+91-1234567890',
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
                    const phoneNumber = 'tel:+1234567890';
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
        ),
      ),
    );
  }
}
