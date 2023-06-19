import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/sub_category_fields.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/main_category_fields.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';
import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../router/app_router_names.dart';
import '../buttons/elevated_button.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

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
    print('Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
  }

  AddExpOrIncCubit getAddExpOrIncCubit() => BlocProvider.of<AddExpOrIncCubit>(context);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
    print('Built Inc');

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
