import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import '../../../../constants/app_presentation_strings.dart';
import 'expense_repeat_type_screen.dart';

class IncomeRepeatTypeScreen extends StatelessWidget {
  const IncomeRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incomeCubit = BlocProvider.of<IncomeRepeatCubit>(context);
    return TransactionRepeatWidget(cubit: incomeCubit, appBarText: AppPresentationStrings.incomeRepeatEng);
  }
}
