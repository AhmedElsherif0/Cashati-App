import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/main_category_fields.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';

class AddIncomeWidget extends StatefulWidget {
  const AddIncomeWidget({Key? key}) : super(key: key);

  @override
  _AddIncomeWidgetState createState() => _AddIncomeWidgetState();
}

class _AddIncomeWidgetState extends State<AddIncomeWidget> with AlertDialogMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
  }

  AddExpOrIncCubit getAddExpOrIncCubit() => BlocProvider.of<AddExpOrIncCubit>(context);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();

    return ListView.builder(
        itemCount: getAddExpOrIncCubit().incomeMainCats.length,
        itemBuilder: (context, index) {
          return MainCategoryFields(
            addExpOrIncCubit: getAddExpOrIncCubit(),
            icons: getAddExpOrIncCubit().incomeMainIcons[index],
            mainCategoryName: getAddExpOrIncCubit().incomeMainCats[index],
            subCategoriesList: getAddExpOrIncCubit().distributeIncomeSubcategories(
              getAddExpOrIncCubit().incomeMainCats[index],
            ),
          );
        });
  }
}
