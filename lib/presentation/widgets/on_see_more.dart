import 'package:flutter/cupertino.dart';

import '../../data/models/transactions/transaction_model.dart';
import '../screens/home/part_time_details.dart';
import '../screens/home/statistics_week_details_screen.dart';

class OnSeeMore extends StatelessWidget {
  const OnSeeMore(
      {super.key,
      required this.generateIndex,
      required this.builderIndex,
      required this.transactions,
      required this.weekRanges});

  final int generateIndex;
  final int builderIndex;
  final List<TransactionModel> transactions;
  final List<String> weekRanges;

  @override
  Widget build(BuildContext context) {
    StatisticsWeekDetailsScreen weeklyDetails = StatisticsWeekDetailsScreen(
        builderIndex: builderIndex,
        transactions: transactions,
        weekRanges: weekRanges);
    switch (generateIndex) {
      case 0:
      case 3:
        return PartTimeDetails(transactionModel: transactions[builderIndex]);
      default:
        weeklyDetails;
    }
    return weeklyDetails;
  }
}
