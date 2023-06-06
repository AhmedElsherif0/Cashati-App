import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import '../../presentation/screens/home/statistics_details_screen.dart';

mixin HelperClass {
  List<String> getWeekRange({required DateTime chosenDay}) {
    int lastDay =
        DateTime(chosenDay.year, chosenDay.month != 12 ? chosenDay.month + 1 : 1, 0)
            .day;
    final chosenMonth = chosenDay.month;
    return [
      'From 1 \\ $chosenMonth   To  7 \\ $chosenMonth',
      'From 8 \\ $chosenMonth   To  14 \\ $chosenMonth',
      'From 15 \\ $chosenMonth   To  21 \\ $chosenMonth',
      'From 22 \\ $chosenMonth   To  28  \\ $chosenMonth',
      'From 29 \\ $chosenMonth   To  $lastDay \\ $chosenMonth'
    ];
  }

  String formatDayDate(DateTime inputDate) =>
      DateFormat('dd / MM/ yyyy').format(inputDate.toLocal()).replaceFirst('0', '');

  String formatWeekDate(DateTime inputDate) =>
      DateFormat(' MM / yyyy').format(inputDate.toLocal()).replaceFirst('0', '');

  onPressed(context, int index) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StatisticsDetailsScreen(
            index: index,
            transactions: context.read<StatisticsCubit>().byDayList,
          ),
        ),
      );
}
