import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/types.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key}) : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  Future<List<Place>> getPlaces() async {
    var location = await Geolocator.getCurrentPosition(
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
      child: Container(),
    );
  }
}
