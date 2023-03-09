
abstract class HomeState {}

class HomeInitial extends HomeState {

}

class ModelExistsSuccState extends HomeState{}
class ModelExistsFailState extends HomeState{}
class FetchedGeneralModelSuccState extends HomeState{}
class AddedGeneralModelSuccState extends HomeState{}
class SuccessState extends HomeState{}