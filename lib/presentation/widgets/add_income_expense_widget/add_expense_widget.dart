import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/main_category_fields.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({Key? key}) : super(key: key);

  @override
  State<AddExpenseWidget> createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList();
  }

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit = BlocProvider.of<AddExpOrIncCubit>(context);
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList();

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
