import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models/city.dart';

class CityProvider extends ChangeNotifier {
  List<City> _cityList = [];

  List<City> get cityList => [..._cityList];

  List<String> cityCategoryList = [
    'Tout',
    'Villes',
    'Communes',
    'Stades',
    'Les Plus Aimés',
  ];

  List<City> findByName(String cityName) {
    return [
      ...cityList.where((oldcity) =>
          oldcity.name.toLowerCase().startsWith(cityName.toUpperCase()))
    ];
  }

  City findById(String cityId) {
    return cityList.firstWhere((oldcity) => oldcity.id == cityId);
  }

  int getLenght() => cityList.length;

  bool iscityListEmpty() => cityList.isEmpty;

  Future<void> fetchAndSetCity() async {
    try {
      final url = Uri.parse(
          "https://tour-ci-default-rtdb.europe-west1.firebasedatabase.app//city.json");

      final response = await http.get(url);
      final dynamic extractedData =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<City> loadedCity = [];
      final List<String> townShipsId = [];
      final List<String> placeIDs = [];
      extractedData.forEach((prodId, prodData) {
      (prodData['twonshipsID'] as List<dynamic>).map((e) => townShipsId.add(e));
      (prodData['placeIDs'] as List<dynamic>).map((e) => placeIDs.add(e));
        loadedCity.add(
          City(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            name: prodData['name'],
            location: LatLng(prodData['latitude'], prodData['longitude']),
            placeIDs: placeIDs,
            twonshipsID: townShipsId,
          ),
        );
      });
      _cityList = loadedCity;
      notifyListeners();
    } catch (error) {
      print('Une erreue est survenue : $error');
      rethrow;
    }
  }

  Future<void> addCity(City city) async {
    final url = Uri.parse(
        "https://tour-ci-default-rtdb.europe-west1.firebasedatabase.app//city.json");

    try {
      final response = await http.post(url,
          body: json.encode({
            'description': city.description,
            'imageUrl': city.imageUrl,
            "latitude": city.location.latitude,
            "longitude": city.location.longitude,
            'name': city.name,
            'placeIDs': city.placeIDs,
            'twonshipsID': city.twonshipsID,
          }));

      final id = json.decode(response.body)['name'];
      final newCity = City(
        id: id,
        description: city.description,
        imageUrl: city.imageUrl,
        location: LatLng(city.location.latitude, city.location.longitude),
        name: city.name,
        placeIDs: city.placeIDs,
        twonshipsID: city.twonshipsID,
      );
      _cityList.add(newCity);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
