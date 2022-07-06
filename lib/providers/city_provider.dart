import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import '../models/city.dart';

class CityProvider extends ChangeNotifier {
  final List<City> _cityList = [
    City(
      id: "id",
      name: "Man",
      description:
          "Ex duis Lorem excepteur pariatur ad velit sit est do sit occaecat labore. Voluptate sit enim ad eu cillum ullamco ut occaecat voluptate anim culpa dolor. Amet esse enim aliquip commodo est ex minim in commodo dolore elit irure. Sit do esse velit ea est id officia enim. Cillum duis laboris elit elit sunt sit qui veniam do enim sunt incididunt. Proident occaecat aute anim occaecat sunt cupidatat consequat qui consequat id qui elit sint id.",
      location: LatLng(10, 10),
      imageUrl:
          "https://afriquinfos.com/wp-content/uploads/2019/09/INP-Houphou%C3%ABt-Boigny-DR.jpg'",
      placeIDs: [],
      twonshipsID: [],
    ),
    City(
      id: "id",
      name: "Man",
      description:
          'Lorem consequat incididunt laboris aliquip dolor adipisicing ex aliqua. Excepteur exercitation dolore esse tempor nulla cillum minim. Qui commodo ea et eu eu qui. Fugiat deserunt qui fugiat mollit magna dolore sunt minim magna. Nulla elit sit eu aliquip laboris sunt nulla duis nostrud et et fugiat aute.',
      location: LatLng(10, 10),
      imageUrl:
          "https://afriquinfos.com/wp-content/uploads/2019/09/INP-Houphou%C3%ABt-Boigny-DR.jpg'",
      placeIDs: [],
      twonshipsID: [],
    )
  ];

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

  int getLenght() => cityList.length;

  bool iscityListEmpty() => cityList.isEmpty;
}
