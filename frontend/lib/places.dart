import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/place.dart';
import 'package:frontend/types.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key}) : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  Future<List<Place>> getPlaces() async {
    final location =
        await getPosition(desiredAccuracy: LocationAccuracy.medium);

    final parsedUrl = Uri.parse((env["API_URL"] ?? "") +
        "api/places/nearby?latitude=${location.latitude}&longitude=${location.longitude}&distance=100000");

    final resp = await http.get(parsedUrl);

    Iterable i = json.decode(resp.body);
    return List<Place>.from(i.map((model) => Place.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    final places = getPlaces();

    return Container(
        child: Scaffold(
      appBar: AppBar(title: Text("Nearby Places")),
      body: FutureBuilder(
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
            return SpinKitFadingCube(
                color: Theme.of(context).primaryColor, size: 50);
          }),
    ));
  }
}

class PlaceCard extends StatefulWidget {
  PlaceCard({Key? key, this.place}) : super(key: key);
  final Place? place;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  Future<dynamic> getReviewsAvg() async {
    var futures = <Future>[];
    for (var id in this.widget.place?.reviews ?? []) {
      futures.add(
          http.get(Uri.parse((env["API_URL"] ?? "") + "api/reviews/${id}")));
    }
    var resp =
        (await Future.wait(futures)).map((data) => json.decode(data.body));
    if (resp.length == 0) return "No Reviews";

    final avg = resp.map((m) => m['stars'].toDouble()).reduce((a, b) => a + b) /
        resp.length;

    return avg;
  }

  @override
  Widget build(BuildContext context) {
    final numStarsFuture = getReviewsAvg();

    return Center(
        child: Card(
            child: InkWell(
                splashColor: Theme.of(context).accentColor.withAlpha(30),
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PlacePage(place: this.widget.place)))
                    },
                child: Column(children: <Widget>[
                  Image(
                    image: NetworkImage(this.widget.place?.imageUrl ?? ""),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(this.widget.place?.name ?? "NULL"),
                    subtitle: FutureBuilder<dynamic>(
                      future: numStarsFuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError)
                          return Text("Something went wrong");

                        if (snapshot.hasData) {
                          if (snapshot.data is double)
                            return Text("${snapshot.data} Stars");
                          else
                            return Text(snapshot.data);
                        }

                        return Container();
                      },
                    ),
                  )
                ]))));
  }
}
