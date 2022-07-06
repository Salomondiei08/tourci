import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tour_ci/theme/app_icon_icons.dart';

import '../helpers/constants.dart';
import '../models/city.dart';
import '../theme/app_theme.dart';

class CityInfoScreen extends StatefulWidget {
  const CityInfoScreen({Key? key}) : super(key: key);

  @override
  State<CityInfoScreen> createState() => CcityInfoScreenState();
}

class CcityInfoScreenState extends State<CityInfoScreen> {
  double mapZoom = kStartZoom;
  double maxZoom = kMaxZoom;
  MapController? mapController;
  List<Marker> markers = [];
  Widget build(BuildContext context) {
    final City city = ModalRoute.of(context)!.settings.arguments as City;

    markers.add(Marker(
      width: 80.0,
      height: 80.0,
      point: city.location,
      builder: (context) => Container(
        child: Icon(
          Icons.location_on,
          size: 40.0,
          color: Colors.red,
        ),
      ),
    ));
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 40.h,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FlexibleSpaceBar(
              background: Hero(
                tag: 'Image2',
                child: CachedNetworkImage(
                  imageUrl: city.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(AppIcon.vr),
              onPressed: () =>
                  Navigator.pushNamed(context, '/vr_view', arguments: city),
            )
          ],
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text('DESCRIPTION',
                      style: Theme.of(context).textTheme.headline2),
                ),
                Container(
                  height: 5,
                  width: 90,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    city.description,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text('LOCALISATION',
                      style: Theme.of(context).textTheme.headline2),
                ),
                Container(
                  height: 5,
                  width: 90,
                  color: Colors.blue,
                ),
                Container(
                    height: 40.h,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: FlutterMap(
                      options: MapOptions(
                        center: city.location,
                        zoom: mapZoom,
                        maxZoom: maxZoom,
                        onPositionChanged: (pos, flag) {
                          if ((pos.zoom! >= kMinZoomStationDisplay &&
                                  mapZoom <= kMinZoomStationDisplay) ||
                              (pos.zoom! <= kMinZoomStationDisplay &&
                                  mapZoom >= kMinZoomStationDisplay)) {
                            setState(() {
                              mapZoom = pos.zoom!;
                            });
                          }
                          mapZoom = pos.zoom!;
                        },
                        onTap: (pos, latLng) {},
                      ),
                      layers: [
                        MarkerLayerOptions(
                          markers: [
                            for (int i = 0; i < markers.length; i++) markers[i]
                          ],
                        ),
                      ],
                      children: [
                        TileLayerWidget(
                          options: TileLayerOptions(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
