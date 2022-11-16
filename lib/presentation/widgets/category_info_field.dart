import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_icons.dart';

class CategoryInfoField extends StatefulWidget {
  const CategoryInfoField({Key? key, required this.mainCategoryName})
      : super(key: key);
  final String mainCategoryName;

  @override
  _CategoryInfoFieldState createState() => _CategoryInfoFieldState();
}

class _CategoryInfoFieldState extends State<CategoryInfoField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(.2),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          title: Text(
            widget.mainCategoryName,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          leading: SvgPicture.asset(AppIcons.editCategoryIcon),
        ),
      ),
    );
  }
}
