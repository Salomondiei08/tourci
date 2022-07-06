import 'package:latlong2/latlong.dart';


class Place {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final LatLng location;
  final List<String> commentsIds;
  final String cityId;
  final String townshipId;
  static int numberOfLikes = 0;
  bool isStadium;
  bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.commentsIds,
    required this.cityId,
    required this.townshipId,
    this.isStadium = false,
    this.isFavorite = false,
  });
}
