import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/main_category_fields.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../router/app_router_names.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

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
    print('Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
  }

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit = BlocProvider.of<AddExpOrIncCubit>(context);
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList();
    print('Built Exp');

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
