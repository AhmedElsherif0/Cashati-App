part of 'statistics_cubit.dart';

@immutable
abstract class StatisticsState {}
class StatisticsInitial extends StatisticsState {}
class StatisticsSuccess extends StatisticsState {}
class StatisticsByDayList extends StatisticsState {}
class StatisticsDeleteTransaction extends StatisticsState {}
class StatisticsChoseDateTime extends StatisticsState {}
class ChoseDateSucc extends StatisticsState {}
class StatisticsTotalExpense extends StatisticsState {}
class FetchedMonthData extends StatisticsState {}
