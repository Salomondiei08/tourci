import 'package:latlong2/latlong.dart';


class City {
  final String id;
  final String name;
  final String description;
  final LatLng location;
  final String imageUrl;
  final List<String> twonshipsID;
  final List<String> placeIDs;
  
  City({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.twonshipsID,
    required this.placeIDs,
  });
}
