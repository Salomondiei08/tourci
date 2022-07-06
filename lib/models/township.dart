import 'package:tour_ci/models/place.dart';

import 'city.dart';

class TownShip {
  final String id;
  final String name;
  final String imageUrl;
  final List<Place> places;
  final City city;

  
  TownShip({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.places,
    required this.city,
  });
}
