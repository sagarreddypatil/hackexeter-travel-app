import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/types.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key, this.review}) : super(key: key);
  final Review? review;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: ListTile(
        title: RatingBar.builder(
          initialRating: review?.stars ?? 0.0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
      )),
    );
  }
}
