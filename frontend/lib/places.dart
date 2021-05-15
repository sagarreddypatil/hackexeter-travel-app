import 'package:flutter/material.dart';

enum PlacesPageType { city, nearby }

class PlacesPage extends StatefulWidget {
  PlacesPage({Key? key, this.type}) : super(key: key);
  final PlacesPageType? type;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
