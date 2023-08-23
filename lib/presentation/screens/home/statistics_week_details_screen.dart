import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/screens/home/part_time_details.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/important_or_fixed.dart';
import 'package:temp/presentation/widgets/transaction_card.dart';

import '../../router/app_router.dart';
import '../../widgets/custom_app_bar.dart';

class StatisticsWeekDetailsScreen extends StatelessWidget with HelperClass {
  const StatisticsWeekDetailsScreen({
    Key? key,
    this.transactions = const [],
    this.weekRanges = const [],
    required this.builderIndex,
  }) : super(key: key);

  final List<TransactionModel> transactions;
  final List<String> weekRanges;
  final int builderIndex;

  String appTitle(index) {
    final transactionType = transactions[0].isExpense
        ? AppStrings.expenses.tr()
        : AppStrings.income.tr();
    return translator.activeLanguageCode == 'en'
        ? '${'the'.tr()} ${AppStrings.week.tr()} $transactionType'
        : '$transactionType ${'the'.tr()}${AppStrings.week.tr()}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final dateTime = getWeekRange(chosenDay: transactions[builderIndex].createdDate)[builderIndex];
    final dateTime = weekRanges[builderIndex];
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            CustomAppBar(title: appTitle(builderIndex), isEndIconVisible: false),
            Text(dateTime, style: theme.textTheme.headline6),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PriorityWidget(),
                      PriorityWidget(
                          text: PriorityType.NotImportant.name,
                          color: AppColor.pinkishGrey)
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_, currIndex) => TransactionsCard(
                  index: currIndex,
                  isRepeated: false,
                  isSeeMore: true,
                  transactionModel: transactions[currIndex],
                  priorityName: transactions[currIndex].isPriority
                      ? AppStrings.important
                      : AppStrings.notImportant,

                  /// check if this is the higherExpense so show it.
                  switchWidget: SwitchWidgets.higherExpenses,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
