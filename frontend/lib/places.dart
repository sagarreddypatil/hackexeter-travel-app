import 'package:flutter/material.dart';
import 'package:frontend/review.dart';
import 'package:geocoding/geocoding.dart';

class Place {
  String? id;
  String? creator;
  Location? location;
  String? name;
  String? address;
  String? zipCode;
  List<Review>? reviews;
}

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
