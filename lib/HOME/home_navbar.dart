import 'package:flutter/material.dart';

class Home_Navbar extends StatefulWidget {
  final String uid;
  const Home_Navbar({super.key, required this.uid});

  @override
  State<Home_Navbar> createState() => Home_NavbarState();
}

class Home_NavbarState extends State<Home_Navbar> {
  int _selectedIndex = 0;
  // String accountName = "";
  // String accountMail = "";
  // String accountMobile = "";

  // // static List<Widget> _widgetOptions = <Widget>[
  // //   message(),
  // //   team(),
  // //   addquery(),
  // //   time(),
  // // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 191, 181, 209),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            // title: Text('Home'),
            label: "Home",
            // backgroundColor: Color.fromARGB(255, 204, 7, 7)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add_rounded,
            ),
            // title: Text('Search'),
            label: "add patient",
            // backgroundColor: Color.fromARGB(255, 100, 10, 10)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services_rounded,
            ),
            // title: Text('Profile'),
            label: "uncollected",
            // backgroundColor: Color(0xFF280A64),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.picture_as_pdf,
            ),
            // title: Text('Profile'),
            label: "Results",
            // backgroundColor: Color(0xFF280A64),
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: Colors.cyan.shade800, size: 40),
        selectedItemColor: Colors.cyan.shade800,
        unselectedItemColor: Colors.cyan.shade300,
        iconSize: 30,
        unselectedFontSize: 14,
        onTap: _onItemTapped,
        elevation: 20);
  }
}
