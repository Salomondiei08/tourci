
import 'package:flutter/material.dart';
import 'package:gaimon/gaimon.dart';

import '../theme/app_theme.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    Key? key,
    required this.listOfIcons,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);

  final List<IconData> listOfIcons;
  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(20),
      height: width * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: width * .024),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Gaimon.selection();
            onTap!(index);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            children: [
              SizedBox(
                width: width * .2125,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? width * .12 : 0,
                    width: index == currentIndex ? width * .2125 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? AppTheme.orange.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Container(
                width: width * .2125,
                alignment: Alignment.center,
                child: Icon(
                  listOfIcons[index],
                  size: width * .076,
                  color:
                      index == currentIndex ? AppTheme.orange : Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
