
abstract class HomeState {}

class HomeInitial extends HomeState {

}

class ModelExistsSuccState extends HomeState{}
class ModelExistsFailState extends HomeState{}
class FetchedGeneralModelSuccState extends HomeState{}
class AddedGeneralModelSuccState extends HomeState{}
class FetchedNotificationListSuccState extends HomeState{}
class FetchedNotificationListFailedState extends HomeState{}
class SuccessState extends HomeState{}
class NotificationYesActionTakenSucc extends HomeState{}