import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/types.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReviewWidget extends StatefulWidget {
  ReviewWidget({Key? key, this.review}) : super(key: key);
  final Review? review;

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  Future<String> getUserName() async {
    final parsedUrl = Uri.parse(
        (env["API_URL"] ?? "") + "api/users/${this.widget.review?.author}");
    return json.decode((await http.get(parsedUrl)).body)['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: ListTile(
        title: FutureBuilder(
            future: getUserName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text("By ${snapshot.data}");
            }),
        subtitle: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                RatingBar.builder(
                  initialRating: this.widget.review?.stars ?? 0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(this.widget.review?.text ?? "")
              ],
            )),
      )),
    );
  }
}
