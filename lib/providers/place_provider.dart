import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../models/place.dart';

class PlaceProvider extends ChangeNotifier {
  List<Place> _placeList = [
  ];

  List<Place> get placeList => [..._placeList];

  List<String> placeCategoryList = [
    'Tout',
    'Hotels',
    'Sites Touristiques',
    'Les Plus Récents',
    'Les Plus Aimés',
  ];

  List<Place> findByName(String placeName) {
    return [
      ...placeList.where((oldPlace) =>
          oldPlace.name.toLowerCase().startsWith(placeName.toLowerCase()))
    ];
  }

  Future<void> addPlace(Place place) async {
    final url = Uri.parse(
        "https://tour-ci-default-rtdb.europe-west1.firebasedatabase.app/place.json");

    try {
      final response = await http.post(url,
          body: json.encode({
            'description': place.description,
            'imageUrl': place.imageUrl,
            "latitude": place.location.latitude,
            "longitude": place.location.longitude,
            'name': place.name,
            'cityId': place.cityId,
            'townshipId': place.townshipId,
            'commentsIds': place.commentsIds,
          }));

      final id = json.decode(response.body)['name'];
      final newPlace = Place(
        id: id,
        description: place.description,
        imageUrl: place.imageUrl,
        location: LatLng(place.location.latitude, place.location.longitude),
        name: place.name,
        cityId: place.cityId,
        commentsIds: place.commentsIds,
        townshipId: place.townshipId,
      );
      _placeList.add(newPlace);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  int numberOfLikes = Place.numberOfLikes;

  int getLenght() => placeList.length;

  bool isPlaceListEmpty() => placeList.isEmpty;

  Future<void> setFavorite(String id) async {
    final url = Uri.parse(
        "https://tour-ci-default-rtdb.europe-west1.firebasedatabase.app/place/$id.json");

    Place place = _placeList.firstWhere((element) => element.id == id);
    final favoriteStatus = place.isFavorite;
    place.isFavorite = !place.isFavorite;
    notifyListeners();
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': place.isFavorite,
            'numberOfLikes': Place.numberOfLikes + 1
          }));

      await http.patch(url,
          body: json.encode({'isFavorite': place.isFavorite}));
      if (response.statusCode >= 400) {
        place.isFavorite = favoriteStatus;
        notifyListeners();
      }
    } catch (error) {
      place.isFavorite = favoriteStatus;
      notifyListeners();
    }
  }

  Future<void> fetchNumberOfLikes() async {
    try {
      final url = Uri.parse(
          "https://tour-ci-default-rtdb.europe-west1.firebasedatabase.app/place.json");

      final response = await http.get(url);
      final dynamic extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      int fetchedNumberOfLikes = 0;
      extractedData.forEach((prodId, prodData) {
        fetchedNumberOfLikes = prodData['numberOfLikes'] as int;
      });
      numberOfLikes = fetchedNumberOfLikes;
      Place.numberOfLikes = fetchedNumberOfLikes;
      notifyListeners();
    } catch (error) {
      print('Une erreue est survenue : $error');
      rethrow;
    }
  }

  Future<void> fetchAndSetPlace() async {
    try {
      final url = Uri.parse(
          "https://tour-ci-default-rtdb.europe-west1.firebasedatabase.app/place.json");

      final response = await http.get(url);
      final dynamic extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Place> loadedPlace = [];
      extractedData.forEach((prodId, prodData) {
        final List<String> commentsIds = [];
        (prodData['commentsIds'] as List<dynamic>)
            .map((e) => commentsIds.add(e));

        loadedPlace.add(
          Place(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
            cityId: prodData['cityId'],
            name: prodData['name'],
            location: LatLng(prodData['latitude'], prodData['longitude']),
            townshipId: prodData['townshipId'],
            commentsIds: commentsIds,
          ),
        );
      });
      _placeList = loadedPlace;
      _placeList.forEach(
        (element) => print(element.name),
      );

      notifyListeners();
    } catch (error) {
      print('Une erreue est survenue : $error');
      rethrow;
    }
  }
}
