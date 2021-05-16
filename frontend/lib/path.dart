import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/review.dart';
import 'package:frontend/types.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PathPage extends StatefulWidget {
  PathPage({Key? key, this.place}) : super(key: key);

  final Path? place;

  @override
  _PathPageState createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
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
        appBar: AppBar(title: Text(this.widget.place?.name ?? "")),
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle2,
                    text: "First Hint: ${this.widget.place?.hints?[0]}",
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
                      if (snapshot.hasData) {
                        if (snapshot.data?.length == 0) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: Text("No Reviews"));
                        } else {
                          var reviewWidgets = <Widget>[];
                          for (Review review in snapshot.data ?? []) {
                            reviewWidgets.add(ReviewWidget(
                                key: Key(review.id ?? ""), review: review));
                          }
                          return Column(children: reviewWidgets);
                          // return ListView.builder(
                          //     itemCount: snapshot.data?.length,
                          //     itemBuilder: (context, index) {
                          //       return ReviewWidget(
                          //           key: Key(snapshot.data?[index].id ?? ""),
                          //           review: snapshot.data?[index]);
                          //     });
                        }
                      }

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
