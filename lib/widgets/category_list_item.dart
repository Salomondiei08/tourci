import 'package:flutter/material.dart';

import '../providers/place_provider.dart';
import '../theme/app_theme.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem({
    Key? key,
    required this.indexSelected,
    required this.elementIndex,
    required this.elementText,
    required this.functionCallBack,
  }) : super(key: key);

  final int indexSelected;
  final int elementIndex;
  final String elementText;
  void Function(int elementIndex) functionCallBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        functionCallBack(elementIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color:
              elementIndex == indexSelected ? AppTheme.orange : AppTheme.gray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            elementText,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color:
                  elementIndex == indexSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
