import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/city.dart';
import '../models/place.dart';
import '../providers/place_provider.dart';
import '../theme/app_theme.dart';

class PlaceListItem extends StatelessWidget {
  const PlaceListItem({
    Key? key,
    required this.placeProvider,
    required this.indexofPlace,
    required this.city,
  }) : super(key: key);

  final PlaceProvider placeProvider;
  final int indexofPlace;
  final String city;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/place_info_screen',
          arguments: placeProvider.placeList[indexofPlace]),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.orange.withOpacity(0.3))),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(children: [
          Expanded(
            child: Hero(
              tag: 'Image',
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                height: 13.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.green, width: 2),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            placeProvider.placeList[indexofPlace].imageUrl))),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeProvider.placeList[indexofPlace].name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 1.h),
                Row(children: [
                  Icon(Icons.place, color: AppTheme.darkGray),
                  Text(city,
                      style: TextStyle(color: AppTheme.darkGray))
                ]),
                const SizedBox(height: 10),
                Divider(
                  color: AppTheme.darkGray,
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    Icon(Icons.favorite_border_outlined,
                        color: AppTheme.orange),
                    SizedBox(width: 2.w),
                    Text(Place.numberOfLikes.toString()),
                    SizedBox(width: 7.w),
                    Icon(Icons.message_outlined, color: AppTheme.orange),
                    SizedBox(width: 2.w),
                    Text(placeProvider
                        .placeList[indexofPlace].commentsIds.length
                        .toString())
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
