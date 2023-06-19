import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';

import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import '../../../constants/app_lists.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../router/app_router_names.dart';
import '../../styles/colors.dart';

class SubCategoryFields extends StatelessWidget {
  const SubCategoryFields(
      {super.key, required this.subCatsList, required this.addExpOrIncCubit});

  final List<SubCategory> subCatsList;
  final AddExpOrIncCubit addExpOrIncCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: GridView.builder(
          itemCount: subCatsList.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            //addExpOrIncCubit.fitRandomColors().shuffle();

            return Visibility(
              visible: index != subCatsList.length - 1,
              replacement: InkWell(
                onTap: () {
                  BlocProvider.of<AddSubcategoryCubit>(context).currentMainCategory =
                      BlocProvider.of<AddExpOrIncCubit>(context).currentMainCat;

                  Navigator.pushNamed(context, AppRouterNames.rAddSubCategory);
                },
                child: SubCategoryChoice(
                  color: AppColor.green,
                  currentID: 'feverrrr',
                  subCategory: AppConstantList().addMoreOption,
                ),
              ),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AddSubcategoryCubit>(context).currentMainCategory =
                      BlocProvider.of<AddExpOrIncCubit>(context).currentMainCat;
                  //TODO assign transaction type , if it is expense or income
                  BlocProvider.of<AddSubcategoryCubit>(context).transactionType =
                      addExpOrIncCubit.isExpense ? 'Expense' : 'Income';
                  addExpOrIncCubit.chooseCategory(subCatsList[index]);
                },
                child: SubCategoryChoice(
                  color: addExpOrIncCubit.fitRandomColors(subCatsList)[index],
                  currentID: addExpOrIncCubit.currentID,
                  subCategory: subCatsList[index],
                ),
              ),
            );
          }),
    );
  }
}
