import 'package:geocoding/geocoding.dart';

class Review {
  String? author;
  double? stars;
  String? text;
  String? forModel;
  String? forId;
  String? id;

  Review(
      {this.author, this.stars, this.text, this.forModel, this.forId, this.id});

  Review.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    stars = json['stars'].toDouble();
    text = json['text'];
    forModel = json['forModel'];
    forId = json['for'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['stars'] = this.stars;
    data['text'] = this.text;
    data['forModel'] = this.forModel;
    data['for'] = this.forId;
    data['id'] = this.id;
    return data;
  }
}

class Path {
  List<String>? reviews;
  List<String>? places;
  List<String>? hints;
  String? creator;
  String? name;
  String? imageUrl;
  String? id;

  Path(
      {this.reviews,
      this.places,
      this.hints,
      this.creator,
      this.name,
      this.imageUrl,
      this.id});

  Path.fromJson(Map<String, dynamic> json) {
    reviews = json['reviews'].cast<String>();
    places = json['places'].cast<String>();
    hints = json['hints'].cast<String>();
    creator = json['creator'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviews'] = this.reviews;
    data['places'] = this.places;
    data['hints'] = this.hints;
    data['creator'] = this.creator;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}

class Place {
  List<String>? reviews;
  String? creator;
  Location? location;
  String? name;
  String? address;
  String? zipCode;
  String? imageUrl;
  String? id;

  Place(
      {this.reviews,
      this.creator,
      this.location,
      this.name,
      this.address,
      this.zipCode,
      this.imageUrl,
      this.id});

  Place.fromJson(Map<String, dynamic> json) {
    reviews = json['reviews'].cast<String>();
    creator = json['creator'];
    location = locationFromJson(json['location']);
    name = json['name'];
    address = json['address'];
    zipCode = json['zipCode'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviews'] = this.reviews;
    data['creator'] = this.creator;
    data['location'] = locationToJson(this.location);
    data['name'] = this.name;
    data['address'] = this.address;
    data['zipCode'] = this.zipCode;
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}

Location locationFromJson(Map<String, dynamic> json) {
  List<double> coordinates = json['coordinates'].cast<double>();
  return Location(
      latitude: coordinates[1],
      longitude: coordinates[0],
      timestamp: DateTime.now());
}

Map<String, dynamic> locationToJson(Location? location) {
  final data = new Map<String, dynamic>();
  if (location == null) {
    data['coordinates'] = [0.0, 0.0];
    return data;
  }
  data['coordinates'] = [location.longitude, location.latitude];
  return data;
}
