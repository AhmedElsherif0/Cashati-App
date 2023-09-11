import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';

import '../../../../styles/colors.dart';
import '../../../../widgets/add_income_expense_widget/main_category_fields.dart';

class AddExpenseOrIncomeScreen extends StatelessWidget {
  const AddExpenseOrIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          initialIndex: context.read<AddExpOrIncCubit>().currentIndex,
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 5.h),
                CustomAppBar(title: AppStrings.addTransaction.tr()),
                SizedBox(height: 1.h),
                TabBar(
                    isScrollable: false,
                    unselectedLabelColor: AppColor.grey,
                    labelColor: AppColor.primaryColor,
                    labelStyle: textTheme.bodyMedium!.copyWith(fontSize: 15.dp),
                    unselectedLabelStyle:
                        textTheme.bodyMedium!.copyWith(fontSize: 15.dp),
                    //  padding: EdgeInsets.symmetric(horizontal: 24.0),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppColor.primaryColor,
                    onTap: (index) =>
                        context.read<AddExpOrIncCubit>().changeCurrentIndex(index),
                    tabs: [
                      Tab(child: Text(AppStrings.expenses.tr())),
                      Tab(child: Text(AppStrings.income.tr()))
                    ]),
                const Expanded(
                  child: TabBarView(
                    children: [AddExpenseWidget(), AddIncomeWidget()],
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}

class AddExpenseWidget extends StatelessWidget {
  const AddExpenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit = BlocProvider.of<AddExpOrIncCubit>(context);
    return ListView.builder(
      itemCount: addExpOrIncCubit.expMainCats.length,
      itemBuilder: (context, index) {
        return MainCategoryFields(
          addExpOrIncCubit: addExpOrIncCubit,
          icons: addExpOrIncCubit.expMainIcons[index],
          mainCategoryName: addExpOrIncCubit.expMainCats[index],
          subCategoriesList: addExpOrIncCubit
              .distributeExpenseSubcategories(addExpOrIncCubit.expMainCats[index]),
        );
      },
    );
  }
}

class AddIncomeWidget extends StatelessWidget {
  const AddIncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit = BlocProvider.of<AddExpOrIncCubit>(context);
    return ListView.builder(
      itemCount: addExpOrIncCubit.incomeMainCats.length,
      itemBuilder: (context, index) {
        return MainCategoryFields(
          addExpOrIncCubit: addExpOrIncCubit,
          icons: addExpOrIncCubit.incomeMainIcons[index],
          mainCategoryName: addExpOrIncCubit.incomeMainCats[index],
          subCategoriesList: addExpOrIncCubit.distributeIncomeSubcategories(
            addExpOrIncCubit.incomeMainCats[index],
          ),
        );
      },
    );
  }
}
