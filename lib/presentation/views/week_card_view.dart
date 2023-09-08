import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_images.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/styles/colors.dart';

import '../../constants/app_icons.dart';
import '../../data/repository/formats_mixin.dart';

class WeekCardViewEdited extends StatefulWidget {
  const WeekCardViewEdited({
    Key? key,
    required this.weeksTotals,
    this.priceColor = AppColor.red,
    this.seeMoreOrDetailsOrHighest,
    required this.weekRanges,
    required this.chosenDay,
    this.priorityColor = AppColor.secondColor,
    required this.onSeeMore,
  }) : super(key: key);

  final List<num> weeksTotals;
  final List<String> weekRanges;
  final DateTime chosenDay;
  final Color priceColor;
  final Color priorityColor;
  final void Function(int) onSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  State<WeekCardViewEdited> createState() => _WeekCardViewEditedState();
}

class _WeekCardViewEditedState extends State<WeekCardViewEdited>
    with FormatsMixin, HelperClass {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isEnglish = translator.activeLanguageCode == 'en';
    return widget.weeksTotals.every((element) => element == 0)
        ? Image.asset(AppImages.noDataCate)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: widget.weeksTotals.length,
            itemBuilder: (context, builderIndex) {
              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.dp),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.dp)),
                    elevation: 4.dp,
                    color: AppColor.lightGrey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Column(
                        children: [
                          Row(
                            textDirection:
                                isEnglish ? TextDirection.ltr : TextDirection.rtl,
                            children: [
                              Text('${AppStrings.week.tr()} ${weekNum(builderIndex)}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headline5),
                              const Spacer(),
                              Text(
                                currencyFormat(
                                    context, widget.weeksTotals[builderIndex]),
                                style: textTheme.headline5
                                    ?.copyWith(color: widget.priceColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Align(
                            alignment: isEnglish
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(widget.weekRanges[builderIndex],
                                style: textTheme.subtitle1),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            textDirection:
                                isEnglish ? TextDirection.ltr : TextDirection.rtl,
                            children: [
                              Column(
                                children: [
                                  // Visibility(
                                  //   visible: isRepeated,
                                  //   child: Column(
                                  //     children: [
                                  //       SizedBox(height: 2.h),
                                  //       Align(
                                  //         alignment: Alignment.centerLeft,
                                  //         child: Text(expenseModel.repeatType,
                                  //             style: textTheme.subtitle1),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Visibility(
                                    visible: true,
                                    child: switchWidgets(
                                        borderLineColor: AppColor.black,
                                        onPress: () {
                                          print("week index is $builderIndex");

                                          widget.onSeeMore(builderIndex);
                                        },
                                        switchWidgets:
                                            widget.seeMoreOrDetailsOrHighest),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h)
                ],
              );
            });
  }
}
