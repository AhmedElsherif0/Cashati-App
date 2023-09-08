import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';

import '../../../constants/app_icons.dart';
import '../../../data/repository/formats_mixin.dart';
import '../../styles/colors.dart';

class DateChooseContainer extends StatelessWidget with FormatsMixin{
  const DateChooseContainer({
    Key? key,
    required this.dateTime,
    required this.onTap,
  }) : super(key: key);
  final DateTime? dateTime;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyText2!;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            title: Text(
              dateTime == null
                  ? AppStrings.chooseDate.tr()
                  : formatDayDate(dateTime!, translator.activeLanguageCode),
              style: theme.copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ),
            leading: SvgPicture.asset(AppIcons.dateIcon),
          ),
        ),
      ),
    );
  }
}
