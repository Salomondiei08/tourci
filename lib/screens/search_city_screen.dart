import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../providers/City_provider.dart';

class SearchCityScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          // backgroundColor: color.kcGrayColor,
          // scaffoldBackgroundColor: color.kcGrayColor,
          appBarTheme: AppBarTheme(
            // color: color.kcGrayColor,
            toolbarTextStyle: const TextTheme(
              headline6: TextStyle(
                  // headline 6 affects the query text
                  // color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ).bodyText2,
            titleTextStyle: const TextTheme(
              headline6: TextStyle(
                  // headline 6 affects the query text
                  // color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ).headline6,
          ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final Citys = Provider.of<CityProvider>(context);
    final results = Citys.cityList
        .where(
          (element) => element.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => Card(
        elevation: 00,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // color: color.kcGrayColor,
        child: ListTile(
          title: Text(
            results[index].name,
            // style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            results[index].description,
            // style: const TextStyle(color: Colors.white),
          ),
          leading: CachedNetworkImage(imageUrl: results[index].imageUrl),
        ),
      ),
      itemCount: results.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final city = Provider.of<CityProvider>(context);
    final results = city.cityList
        .where(
          (element) => element.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return query.isEmpty
        ? Center(
            child: Text(
              "Rien n'a été trouvé",
         
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              itemBuilder: (context, index) => Card(
                elevation: 00,
                // color: color.kcGrayColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  onTap: () => Navigator.of(context).pushNamed(
                    '/City_info_screen',
                    arguments: results[index],
                  ),
                  title: Text(
                    results[index].name,
             
                  ),
                  subtitle: Text(
                    results[index].description,
                  ),
                  leading: Image.network(results[index].imageUrl),
                ),
              ),
              itemCount: results.length,
            ),
          );
  }
}
