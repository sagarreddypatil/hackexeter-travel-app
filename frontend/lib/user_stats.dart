import 'package:flutter/material.dart';

class UserStatsPage extends StatefulWidget {
  UserStatsPage({Key? key}) : super(key: key);

  @override
  _MyUserStatsPageState createState() => _MyUserStatsPageState();
}

class _MyUserStatsPageState extends State<UserStatsPage> {
  // void goToPlacesPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PlacesPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [new Container(
          decoration: BoxDecoration (
              color: Colors.blueAccent,
              border: Border.all(
                color: Colors.black,
                width: 8,
              ),
              borderRadius: BorderRadius.circular(12)
          ),
        ),]
    );
  }
}
