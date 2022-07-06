import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../screens/search_city_screen.dart';
import '../screens/search_place_screen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.context,
    required bool isPlaceMode,
  })  : _isPlaceMode = isPlaceMode,
        super(key: key);

  final BuildContext context;
  final bool _isPlaceMode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () => showSearch(
            context: context,
            delegate: _isPlaceMode?  SearchPlaceScreen() : SearchCityScreen(),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            height: 7.h,
            width: 99.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
               _isPlaceMode?     'Rechercher un endroit' : "Rechercher une ville",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.search, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
