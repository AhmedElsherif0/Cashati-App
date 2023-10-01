import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/decorations.dart';

import '../../styles/colors.dart';

class WelcomeDropDownButton extends StatelessWidget {
  final Color? iconColor;
  final List<String> items;
  final bool isExpanded;
  final bool isDirection;
  final String selectedValue;
  final void Function(String?) onChange;

  const WelcomeDropDownButton({
    Key? key,
    this.iconColor,
    required this.selectedValue,
    required this.items,
    this.isExpanded = false,
    this.isDirection = true,
    required this.onChange,
  }) : super(key: key);

  bool get isEqual => selectedValue != AppStrings.chooseCurrency.tr();

  Color get dropDownColor => isEqual ? AppColor.white : AppColor.primaryColor;

  Color get getCardColor => isEqual ? AppColor.primaryColor : AppColor.white;

  IconData get iconDirection =>
      isDirection ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 8.h,
      width: 100.w,
      child: Card(
        color: getCardColor,
        shape: AppDecorations.dropDownCurrency,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.dp),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: isExpanded,
              elevation: 8,
              menuMaxHeight: 25.h,
              iconEnabledColor: AppColor.primaryColor,
              disabledHint: Text(items[0]),
              isDense: true,
              borderRadius: BorderRadius.circular(12.dp),
              focusColor: AppColor.primaryColor,
              iconDisabledColor: AppColor.primaryColor,
              dropdownColor: isExpanded ? AppColor.primaryColor : AppColor.white,
              style: textTheme.bodyText2,
              icon: Icon(
                  size: 34.dp,
                  isExpanded ? Icons.keyboard_arrow_down : iconDirection,
                  color: dropDownColor),
              hint: Text(selectedValue,
                  style: textTheme.bodyText2?.copyWith(color: dropDownColor)),
              items: List.generate(
                  items.length,
                  (index) => DropdownMenuItem<String>(
                        value: items[index],
                        child: Center(
                            child: Text(items[index].tr(),
                                style: textTheme.bodyText2
                                    ?.copyWith(fontWeight: FontWeight.w500))),
                      ),
                  growable: false),
              onChanged: onChange,
            ),
          ),
        ),
      ),
    );
  }
}
