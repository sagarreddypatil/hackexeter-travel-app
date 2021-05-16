import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/review.dart';
import 'package:frontend/types.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PlacePage extends StatefulWidget {
  PlacePage({Key? key, this.place}) : super(key: key);

  final Place? place;

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  Future<List<Review>> getReviews() async {
    final parsedUrl = Uri.parse(
        (env["API_URL"] ?? "") + "api/reviews/for/${this.widget.place?.id}");

    final resp = await http.get(parsedUrl);
    Iterable i = json.decode(resp.body);
    return List<Review>.from(i.map((model) => Review.fromJson(model)));
  }

  @override
  Widget build(BuildContext context) {
    final reviewsFuture = getReviews();

    return Scaffold(
        appBar: AppBar(title: Text("Nearby Paths")),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Center(
              child: ListView(
            children: <Widget>[
              Image(
                image: NetworkImage(this.widget.place?.imageUrl ?? ""),
                height: 200,
                fit: BoxFit.cover,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline3,
                  text: this.widget.place?.name,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle1,
                    text: "Address: ${this.widget.place?.address}",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle1,
                    text: "Zip Code: ${this.widget.place?.zipCode}",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.subtitle1,
                        text: "Reviews",
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: reviewsFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Review>> snapshot) {
                      if (snapshot.hasData)
                        ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return ReviewWidget(
                                  review: snapshot.data?[index]);
                            });

                      return Container();
                    },
                  )
                ]),
              )
            ],
          )),
        ));
  }
}
