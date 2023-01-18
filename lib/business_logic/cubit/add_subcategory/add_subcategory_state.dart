part of 'add_subcategory_cubit.dart';

@immutable
abstract class AddSubcategoryState {


}

class AddSubcategoryInitial extends AddSubcategoryState {}
class ChoseSubCategory extends AddSubcategoryState {}
class AddedExpSubcategorySuccessfully extends AddSubcategoryState {}
class AddedIncSubcategorySuccessfully extends AddSubcategoryState {}
class AddSubCategoryLoading extends AddSubcategoryState {


}
class AddSubCategoryError extends AddSubcategoryState {
  final String message;
  AddSubCategoryError(this.message);
}
