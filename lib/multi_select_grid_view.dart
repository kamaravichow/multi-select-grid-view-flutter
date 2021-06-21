library multi_select_grid_view;

import 'package:flutter/material.dart';

class MSItem {
  String text;
  bool hasIcon;
  String icon;

  MSItem({
    required this.text,
    this.hasIcon = false,
    this.icon = "",
  });
}

class MultiSelectGridView extends StatefulWidget {
  final List<MSItem> items;
  const MultiSelectGridView({Key? key, required this.items}) : super(key: key);

  @override
  _MultiSelectGridViewState createState() => _MultiSelectGridViewState();
}

class _MultiSelectGridViewState extends State<MultiSelectGridView> {
  List<int> _selectedIndices = [];
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          bool _isThisSelected = _selectedIndices.contains(index);
          return _MSGridItem(
            title: widget.items[index].text,
            hasIcon: widget.items[index].hasIcon,
            image: widget.items[index].icon,
            isSelected: _isThisSelected,
            onSelected: () {},
          );
        },
      ),
    );
  }
}

class _MSGridItem extends StatelessWidget {
  final bool isSelected;
  final String image;
  final bool hasIcon;
  final String title;
  final Function() onSelected;

  //Optional Customsations
  final double strokeWidth;
  final Color strokeColor;
  final double optionItemBorderRadius;

  const _MSGridItem({
    Key? key,
    required this.onSelected,
    required this.title,
    required this.hasIcon,
    // Optional Attributes

    this.isSelected = false,
    this.image = "",
    this.strokeWidth = 5,
    this.strokeColor = Colors.purple,
    this.optionItemBorderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border;
    if (isSelected) {
      border = Border.all(
        color: strokeColor,
        width: strokeWidth,
      );
    } else {
      border = Border.all(
        color: Colors.transparent,
      );
    }
    return InkWell(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(optionItemBorderRadius),
          border: border,
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: 60,
              width: 60,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
