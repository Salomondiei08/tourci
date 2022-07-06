import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';

import '../models/place.dart';

class PlaceProvider extends ChangeNotifier {
  List<Place> _placeList = [
    Place(
        id: "02934",
        name: "La statut Akwaba",
        description:
            "Voluptate ea quis proident sint magna quis velit. Velit veniam enim labore ex ipsum aute pariatur. Dolore irure commodo cillum Lorem ut. Laborum tempor quis tempor id duis commodo do proident aliqua quis ex occaecat ut nulla.",
        imageUrl:
            "https://afriquinfos.com/wp-content/uploads/2019/09/INP-Houphou%C3%ABt-Boigny-DR.jpg'",
        location: LatLng(5.316667, -4.033333),
        cityId: '',
        commentsIds: [],
        townshipId: ''),
    Place(
      id: "02934",
      name: "La Statut Akwaba",
      description: "OKNJDKFON",
      imageUrl:
          "https://afriquinfos.com/wp-content/uploads/2019/09/INP-Houphou%C3%ABt-Boigny-DR.jpg'",
      location: LatLng(10, 10),
      cityId: '',
      commentsIds: [],
      townshipId: '',
    )
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
          oldPlace.name.toLowerCase().startsWith(placeName.toUpperCase()))
    ];
  }

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
          body: json.encode({'isFavorite': place.isFavorite}));
          
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

  Future<void> fetchAndSetPlace() async {
    try {
      final url = Uri.parse(
          "https://shoppy-59758-default-rtdb.europe-west1.firebasedatabase.app/place.json");

      final response = await http.get(url);
      final dynamic extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Place> loadedPlace = [];
      extractedData.forEach((prodId, prodData) {
        loadedPlace.add(
          Place(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
            cityId: prodData['cityId'],
            name: prodData['name'],
            location: prodData['location'],
            townshipId: prodData['townshipId'],
            commentsIds: prodData['commentsIds'],
          ),
        );
      });
      _placeList = loadedPlace;
      notifyListeners();
    } catch (error) {
      print('Une erreue est survenue : $error');
      rethrow;
    }
  }
}
