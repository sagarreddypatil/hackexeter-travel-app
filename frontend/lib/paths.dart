import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/path.dart';
import 'package:frontend/types.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';

class PathsPage extends StatefulWidget {
  PathsPage({Key? key}) : super(key: key);

  @override
  _PathsPageState createState() => _PathsPageState();
}

class _PathsPageState extends State<PathsPage> {
  Future<List<Path>> getPlaces() async {
    final location =
        await getPosition(desiredAccuracy: LocationAccuracy.medium);

    final parsedUrl = Uri.parse((env["API_URL"] ?? "") +
        "api/paths/nearby?latitude=${location.latitude}&longitude=${location.longitude}&distance=100000");

    final resp = await http.get(parsedUrl);

    Iterable i = json.decode(resp.body);
    return List<Path>.from(i.map((model) => Path.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    final places = getPlaces();

    return Scaffold(
        appBar: AppBar(title: Text("Nearby Paths")),
        body: Container(
          child: FutureBuilder(
              future: places,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Path>> snapshot) {
                if (snapshot.hasError) return Text("Something went wrong");
                if (snapshot.hasData)
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return PathCard(
                            key: Key(snapshot.data?[index].id ?? ""),
                            place: snapshot.data?[index]);
                      });
                return SpinKitFadingCube(
                    color: Theme.of(context).primaryColor, size: 50);
              }),
        ));
  }
}

class PathCard extends StatefulWidget {
  PathCard({Key? key, this.place}) : super(key: key);
  final Path? place;

  @override
  _PathCardState createState() => _PathCardState();
}

class _PathCardState extends State<PathCard> {
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
                builder: (context) => PathPage(place: this.widget.place)))
      },
      child: Column(
        children: <Widget>[
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
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) return Text("Something went wrong");

                if (snapshot.hasData) {
                  if (snapshot.data is double)
                    return Text("${snapshot.data} Stars");
                  else
                    return Text(snapshot.data);
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    )));
  }
}
