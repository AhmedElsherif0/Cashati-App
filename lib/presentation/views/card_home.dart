import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/buttons/dotted_button.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../styles/colors.dart';
import '../styles/decorations.dart';

class CardHome extends StatelessWidget with HelperClass {
  const CardHome({
    Key? key,
    required this.title,
    required this.onShow,
    required this.onAdd,
    required this.generalStatsModel,
    required this.isExpense,
  }) : super(key: key);

  final String title;
  final GeneralStatsModel generalStatsModel;
  final bool isExpense;
  final Function() onShow;
  final Function() onAdd;

  String topTransaction(Box<GeneralStatsModel> thisBox) {
    GeneralStatsModel ourGeneral =
        thisBox.get(AppStrings.onlyId) ?? generalStatsModel;
    return isExpense
        ? '${ourGeneral.topExpense} ,${currencyFormat(ourGeneral.topExpenseAmount)}'
        : '${ourGeneral.topIncome}, ${currencyFormat(ourGeneral.topIncomeAmount)} ';
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = translator.activeLanguageCode == 'ar';
    Hive.isBoxOpen(AppBoxes.generalStatisticsBox);
    final textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder<Box<GeneralStatsModel>>(
        valueListenable: HiveHelper()
            .getBoxName<GeneralStatsModel>(boxName: AppBoxes.generalStatisticsBox)
            .listenable(),
        builder: (context, box, _) {
          GeneralStatsModel ourGeneral =
              box.get(AppStrings.onlyId) ?? generalStatsModel;
          return Stack(
            children: [
              /// Show Expense or Income.
              Padding(
                padding: EdgeInsets.only(top: 42.dp),
                child: DecoratedBox(
                  decoration: AppDecorations.homeCard,
                  child: Padding(
                    padding: EdgeInsets.only(right: 14.dp, bottom: 8.dp),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: UnderLineTextButton(
                        text: '${AppStrings.show.tr()} ${title.tr()}',
                        onPressed: onShow,
                        textStyle: TextStyle(fontSize: 14.dp, color: AppColor.white),
                        decorationColor: AppColor.white,
                        padding: EdgeInsets.only(left: !isEnglish ? 14.dp : 0),
                      ),
                    ),
                  ),
                ),
              ),

              ///  Stacked Balance Widget.
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(
                      isExpense
                          ? AppStrings.topExpenseOfMonth.tr()
                          : AppStrings.topIncomeOfMonth.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 1.h),
                    FittedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.dp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 50,
                              offset: const Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 14.dp,
                              right: translator.activeLanguageCode == 'en'
                                  ? 10.dp
                                  : 14.dp,
                              left: translator.activeLanguageCode == 'en'
                                  ? 14.dp
                                  : 10.dp,
                              bottom: 14.dp),
                          child: Column(
                            children: [
                              SvgPicture.asset('assets/icons/download.svg',
                                  height: 20.dp, width: 20.dp),
                              SizedBox(height: 2.h),
                              Center(
                                child:  Text( topTransaction(box),
                                    textDirection:
                                        translator.activeLanguageCode == 'en'
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                    style: textTheme.headline6,
                                    maxLines: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Dotted Widget
              Padding(
                padding: EdgeInsets.only(top: 22.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DottedButton(
                        icon: AppIcons.balance,
                        text: ourGeneral.balance == 0
                            ? '${AppStrings.balance.tr()} ${currencyFormat(0.00)}'
                            : currencyFormat(ourGeneral.balance).tr(),
                        onPressed: () {}),
                    SizedBox(height: 2.h),
                    DottedButton(
                        icon: AppIcons.addWhite,
                        text: '${AppStrings.add.tr()} ${title.tr()}',
                        onPressed: onAdd),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
