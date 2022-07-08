import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tour_ci/providers/city_provider.dart';

import '../theme/app_theme.dart';
import '../widgets/category_list_item.dart';
import '../widgets/city_item.dart';
import '../widgets/search_widget.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({Key? key}) : super(key: key);

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  bool _isDataLoading = false;

  Future<void> getOlineData() async {
    setState(() {
      _isDataLoading = true;
    });

    await Provider.of<CityProvider>(context, listen: false).fetchAndSetCity();
    setState(() {
      _isDataLoading = false;
    });
  }

  int indexSelected = 0;

  @override
  void initState() {
    if (Provider.of<CityProvider>(context, listen: false).cityList.isEmpty) {
      getOlineData();
    }
    super.initState();
  }

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
                              isPlaceMode: false,
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
              child: Consumer<CityProvider>(
                builder: (context, cityProvider, child) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cityProvider.cityCategoryList.length,
                    itemBuilder: (_, i) => CategoryListItem(
                          elementText: cityProvider.cityCategoryList[i],
                          elementIndex: i,
                          indexSelected: indexSelected,
                          functionCallBack: _changeElement,
                        )),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Consumer<CityProvider>(
                builder: (context, cityProvider, child) => _isDataLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: getOlineData,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: cityProvider.cityList.length,
                            itemBuilder: (context, i) {
                              return CityItem(
                                city: cityProvider.cityList[i],
                              );
                            }),
                      )),
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
