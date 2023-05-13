part of 'statistics_cubit.dart';

@immutable
abstract class StatisticsState {}
class StatisticsInitial extends StatisticsState {}
class StatisticsByDayList extends StatisticsState {}
class StatisticsChoseDateTime extends StatisticsState {}
class ChoseDateSucc extends StatisticsState {}
class FetchedMonthData extends StatisticsState {}
