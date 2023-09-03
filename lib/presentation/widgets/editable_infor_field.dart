import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/colors.dart';

import '../../constants/app_icons.dart';

class EditableSubCategField extends StatefulWidget {
   EditableSubCategField({Key? key, this.subCategoryName}) : super(key: key);
   TextEditingController? subCategoryName;

  @override
  _EditableSubCategFieldState createState() => _EditableSubCategFieldState();
}

class _EditableSubCategFieldState extends State<EditableSubCategField> {

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.dividerColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          title: TextFormField(
            controller:widget.subCategoryName,
            validator: (value){
              if(value!.isEmpty) return AppStrings.cantBeEmpty.tr();

              return null;
            },
            cursorColor: AppColor.primaryColor,
            style:  Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w300,),
            decoration: InputDecoration(
                hintText: AppStrings.writeSubcategoryName.tr(),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
                border: InputBorder.none),
          ),
          leading:  SvgPicture.asset(AppIcons.categories),
        ),
      ),
    );
  }
}
