import 'package:flutter/material.dart';
import 'places.dart';
import 'user_stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelExplorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TravelExplorer Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void goToPlacesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlacesPage()),
    );
  }

  int _selectedIndex = 0;
  static int numCompleted = 15;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle statTitleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const TextStyle statValStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Map',
      style: optionStyle,
    ),
    Text(
      'Index 1: Places',
      style: optionStyle,
    ),
    Scaffold(
      appBar: AppBar(
        title: Text("potato"),
      ),
      body: ListView(
          children: [
            new Container(
              height: 200,
              width: 350,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              decoration: BoxDecoration (
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Text(
                "Path #1",
                style: statTitleStyle,
              ),
            ),
            new Container(
              height: 200,
              width: 350,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              decoration: BoxDecoration (
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Text(
                "Path #2",
                style: statTitleStyle,
              ),
            ),
            new Container(
              height: 200,
              width: 350,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              decoration: BoxDecoration (
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Text(
                "Path #3",
                style: statTitleStyle,
              ),
            ),
          ]
      ),
    ),
    Text(
      'Index 3: Meme',
      style: optionStyle,
    ),
    Scaffold(
      body:Center(
        child: Column(
          children: [
            Text(
              '\n\nIndex 4: Stats',
              style: optionStyle,
            ),
            new Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration (
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Text(
                "Completed: \n" + (numCompleted.toString()),
                style: statTitleStyle,
              ),
            ),
          ]
        ),
      ),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlacesPage()),
      );
    }

    // if (_selectedIndex == 0) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => PlacesPage()),
    //   );
    // }
    //
    // if (_selectedIndex == 2) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => PlacesPage()),
    //   );
    // }
    //
    // if (_selectedIndex == 3) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => PlacesPage()),
    //   );
    // }

    // if (_selectedIndex == 4) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => UserStatsPage()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title!),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Meme',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined ),
            label: 'User Stats',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
