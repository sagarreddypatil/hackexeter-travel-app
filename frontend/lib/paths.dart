import 'package:flutter/material.dart';
import 'package:frontend/places.dart';
import 'package:frontend/review.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Path {
  String? creator;
  String? name;
  List<Review>? reviews;
  List<Place>? places;
  List<String>? hints;
}

class PathsPage extends StatelessWidget {
  PathsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    return Scaffold(
        appBar: AppBar(title: Text("Popular Paths Nearby")),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
                height: 50,
                color: Colors.amber[600],
                child: const Center(child: Text("Yeet")))
          ],
        ));
  }
}

class PathButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}
