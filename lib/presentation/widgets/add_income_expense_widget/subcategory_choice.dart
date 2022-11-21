import 'package:flutter/material.dart';

import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../styles/colors.dart';

class SubCategoryChoice extends StatefulWidget {
  const SubCategoryChoice({
    Key? key,
    required this.color,
    required this.currentID,
    required this.subCategoryExpense,
  }) : super(key: key);
  final Color color;
  final String currentID;
  final SubCategoryExpense subCategoryExpense;

  @override
  _SubCategoryChoiceState createState() => _SubCategoryChoiceState();
}

class _SubCategoryChoiceState extends State<SubCategoryChoice> {
  BoxDecoration animatedDecoration(Color color) => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1),
      );

  @override
  Widget build(BuildContext context) {
    const duration400 = Duration(milliseconds: 400);
    return Visibility(
      visible: widget.subCategoryExpense.id == widget.currentID,
      replacement: AnimatedContainer(
        duration: duration400,
        // height: 91,
        //   width: 129,
        decoration: animatedDecoration(widget.color),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconData(
                  widget.subCategoryExpense.subCategoryExpenseIconCodePoint),
              color: widget.color,
            ),
            const SizedBox(height: 5),
            Text(
              widget.subCategoryExpense.subCategoryExpenseName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: widget.color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      child: AnimatedContainer(
        duration: duration400,
        // height: 91,
        //   width: 129,
        decoration: animatedDecoration(widget.color),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconData(
                  widget.subCategoryExpense.subCategoryExpenseIconCodePoint),
              color: AppColor.white,
            ),
            const SizedBox(height: 5),
            Text(
              widget.subCategoryExpense.subCategoryExpenseName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
