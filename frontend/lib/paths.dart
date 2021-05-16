import 'package:flutter/material.dart';
import 'package:frontend/places.dart';
import 'package:frontend/review.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Path {
  String? creator;
  String? name;
  List<Review>? reviews;
  List<Place>? places;
  List<String>? hints;
}

class PathsPage extends StatefulWidget {
  const PathsPage({Key? key}) : super(key: key);

  @override
  State<PathsPage> createState() => _PathsPageState();
}

class _PathsPageState extends State<PathsPage> {
  @override
  Widget build(BuildContext context) {
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
  PathButton({Key? key, required this.path}) : super(key: key);
  final Path path;

  @override
  Widget build(BuildContext context) {
    String pathName = path.name ?? "";
    double rating = (path.reviews ?? [Review()])
        .map((m) => m.stars ?? 0)
        .reduce((a, b) => a + b);

    return Center(
        child: Card(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.location_on),
            title: Text(pathName),
            subtitle: SmoothStarRating(
              isReadOnly: true,
              rating: rating,
            ))
      ],
    )));
  }
}
