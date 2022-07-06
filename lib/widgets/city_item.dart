import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/city.dart';
import '../providers/city_provider.dart';

class CityItem extends StatelessWidget {
  const CityItem({
    Key? key,
 required this.city,
  }) : super(key: key);

  final City city;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/city_info_screen',
          arguments: city),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          height: 20.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(city.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              city.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
