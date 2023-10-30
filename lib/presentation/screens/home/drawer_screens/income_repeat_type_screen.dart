import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import '../../../../constants/app_strings.dart';
import 'expense_repeat_type_screen.dart';

class IncomeRepeatTypeScreen extends StatelessWidget {
  const IncomeRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeRepeatCubit, IncomeRepeatCubitStates>(
      builder: (context, state) {
        return TransactionRepeatWidget(
            cubit: BlocProvider.of<IncomeRepeatCubit>(context),
            appBarText: AppStrings.incomeRepeat);
      },
    );
  }
}
