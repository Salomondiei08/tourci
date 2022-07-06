import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../helpers/constants.dart';
import '../models/place.dart';
import '../theme/app_icon_icons.dart';

class PageInfoScreen extends StatefulWidget {
  const PageInfoScreen({Key? key}) : super(key: key);

  @override
  State<PageInfoScreen> createState() => _PageInfoScreenState();
}

class _PageInfoScreenState extends State<PageInfoScreen> {
  double mapZoom = kStartZoom;
  double maxZoom = kMaxZoom;
  MapController? mapController;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    markers.add(Marker(
      width: 80.0,
      height: 80.0,
      point: place.location,
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
                tag: 'Image1',
                child: CachedNetworkImage(
                  imageUrl: place.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(AppIcon.vr),
              onPressed: () =>
                  Navigator.pushNamed(context, '/vr_view', arguments: place),
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
                    place.description,
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
                        center: place.location,
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
