import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tour_ci/models/place.dart';
import 'package:tour_ci/providers/place_provider.dart';

import 'package:tour_ci/screens/search_place_screen.dart';

import '../theme/app_theme.dart';
import '../widgets/category_list_item.dart';
import '../widgets/place_item_list.dart';
import '../widgets/search_widget.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tour",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: AppTheme.orange, fontSize: 33),
                        ),
                        Text(
                          "CI",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: AppTheme.green, fontSize: 33),
                        ),
                        const SizedBox(width: 5),
                        const SizedBox(
                          height: 27,
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    const SizedBox(width: double.infinity),
                    SizedBox(
                      height: 8.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 65.w,
                            child: SearchWidget(
                              context: context,
                              isPlaceMode: true,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 7.h,
                            width: 7.h,
                            decoration: BoxDecoration(
                              color: AppTheme.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Consumer<PlaceProvider>(
                builder: (context, placeProvider, child) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: placeProvider.placeCategoryList.length,
                    itemBuilder: (_, i) => CategoryListItem(
                          elementText:  placeProvider.placeCategoryList[i],
                          elementIndex: i,
                          indexSelected: indexSelected,
                          functionCallBack: _changeElement,
                        )),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Consumer<PlaceProvider>(
              builder: (context, placeProvider, child) => ListView.builder(
                itemCount: placeProvider.placeList.length,
                itemBuilder: (context, i) {
                  return PlaceListItem(
                      placeProvider: placeProvider, indexofPlace: i);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changeElement(int elementIndex) {
    setState(() {
      indexSelected = elementIndex;
    });
  }
}

