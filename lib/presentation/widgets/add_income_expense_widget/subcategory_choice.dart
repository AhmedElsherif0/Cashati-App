import 'package:flutter/material.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/styles/decorations.dart';

import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';

class SubCategoryChoice extends StatelessWidget {
  const SubCategoryChoice(
      {Key? key,
      required this.subCategory,
      required this.currentID,
      required this.color})
      : super(key: key);
  final SubCategory subCategory;
  final Color color;
  final String currentID;

  Color _fontColor() => subCategory.id == currentID ? AppColor.white : color;

  BoxDecoration _decoration() => subCategory.id == currentID
      ? AppDecorations.dTabBoxDecoration(color)
      : AppDecorations.animatedDecoration(color);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: 5),
      duration: AppDecorations.duration600ms,
      decoration: _decoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(AppConstantList().iconsOfApp[subCategory.subCategoryIconName],
              color: _fontColor()),
          const SizedBox(height: 10),
          Text(
            subCategory.subCategoryName,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: _fontColor(), fontSize: 15, fontWeight: FontWeight.w500),
            overflow: TextOverflow.clip,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
