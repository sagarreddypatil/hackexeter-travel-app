import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/types.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key}) : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  Future<List<Place>> getPlaces() async {
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    final resp = await http.get(
      Uri.parse(env["API_URL"] ??
          "" +
              "/api/places/nearby?latitude=${location.latitude}&longitude=${location.longitude}&distance=100000"),
    );

    Iterable i = json.decode(resp.body);
    return List<Place>.from(i.map((model) => Place.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    final places = getPlaces();

    return Container(
      child: FutureBuilder(
          future: places,
          builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
            if (snapshot.hasError) return Text("Something went wrong");
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return PlaceCard(
                        key: Key(snapshot.data?[index].id ?? ""),
                        place: snapshot.data?[index]);
                  });
            return SpinKitFadingCube(size: 50);
          }),
    );
  }
}

class PlaceCard extends StatefulWidget {
  PlaceCard({Key? key, this.place}) : super(key: key);
  final Place? place;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  Future<double> getReviewsAvg() async {
    var futures = <Future>[];
    for (var d in this.widget.place?.reviews ?? []) {
      futures
          .add(http.get(Uri.parse(env["API_URL"] ?? "" + "/api/reviews/${d}")));
    }
    var resp = await Future.wait(futures);

    return resp.map((data) => json.decode(data)).reduce(
        (a, b) => a['stars'].cast<double>() + b['stars'].cast<double>());
  }

  @override
  Widget build(BuildContext context) {
    final numStarsFuture = getReviewsAvg();

    return Center(
        child: Card(
            child: InkWell(
                splashColor: Theme.of(context).accentColor.withAlpha(30),
                onTap: () {
                  //do stuff here
                },
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(this.widget.place?.name ?? "NULL"),
                  subtitle: FutureBuilder<double>(
                    future: numStarsFuture,
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.hasError)
                        return Text("Something went wrong");

                      if (snapshot.hasData)
                        return SmoothStarRating(
                            isReadOnly: true, rating: snapshot.data);

                      return Container();
                    },
                  ),
                ))));
  }
}
