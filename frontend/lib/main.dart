import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:frontend/paths.dart';
import 'package:frontend/places.dart';
import 'package:frontend/types.dart';
import 'package:geolocator/geolocator.dart';

Future main() async {
  await DotEnv.load();
  runApp(MyApp());
}

Future<Position> getPosition(
    {LocationAccuracy desiredAccuracy = LocationAccuracy.medium}) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(desiredAccuracy: desiredAccuracy);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue, primary: Colors.white))),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CityScape"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                      text: "Welcome",
                      style: Theme.of(context).textTheme.headline1),
                  textScaleFactor: 0.8,
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text("Nearby Paths"),
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PathsPage()))
                    },
                  ),
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text("Nearby Places"),
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PlacesPage()))
                    },
                  ),
                )),
            SizedBox(height: 100),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text("Add Content"),
                    onPressed: () => {},
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
