part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LanguageChangedState extends GlobalState {}
class CurrencyChangedState extends GlobalState {}
class ChangeLanguageBGColorState extends GlobalState {}
class ChangeCurrencyBGColorState extends GlobalState {}
class ChangeScreenState extends GlobalState{}
class ChangeEnableNotifications extends GlobalState{}
class CanceledDailyNotification extends GlobalState{}
class SavedDailyNotification extends GlobalState{}
class ChangeNotificationTime extends GlobalState{}
class OpenDrawerState extends GlobalState{}
