/*
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class SubCategoryChoice extends StatefulWidget {
   SubCategoryChoice({Key? key,
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
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.subCategoryExpense.subCategoryExpenseId==widget.currentID,
        replacement:  AnimatedContainer(
          duration: Duration(milliseconds: 400),
          // height: 91,
          //   width: 129,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.color,width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(IconData(widget.subCategoryExpense.subCategoryExpenseIconCodePoint),color: widget.color,),
              SizedBox(height: 5,),
              Text(widget.subCategoryExpense.subCategoryExpenseName,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: widget.color,fontSize: 15,fontWeight: FontWeight.w500),)
            ],
          ),
        ),
    child:  AnimatedContainer(
      duration: Duration(milliseconds: 400),
      // height: 91,
      //   width: 129,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.color,width: 1),
          color: widget.color
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(IconData(widget.subCategoryExpense.subCategoryExpenseIconCodePoint),color:AppColor.white,),
          SizedBox(height: 5,),
          Text(widget.subCategoryExpense.subCategoryExpenseName,style: Theme.of(context).textTheme.bodySmall!.copyWith(color:AppColor.white,fontSize: 15,fontWeight: FontWeight.w500),)
        ],
      ),
    ),
    );
  }
}
*/
