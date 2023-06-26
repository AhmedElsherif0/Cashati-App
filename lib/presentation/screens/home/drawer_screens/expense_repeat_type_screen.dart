import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import 'package:temp/presentation/widgets/expense_repeat_header.dart';

import '../../../../business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import '../../../../constants/app_icons.dart';
import '../../../../constants/enum_classes.dart';
import '../../../router/app_router.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/common_texts/details_text.dart';
import '../statistics_details_screen.dart';

class ExpenseRepeatTypeScreen extends StatelessWidget with HelperClass {
  const ExpenseRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseCubit = BlocProvider.of<ExpenseRepeatCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            /// Custom AppBar.
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                child: CustomAppBar(
                  title: 'Expense Repeat',
                  onTapFirstIcon: () => Navigator.of(context).pop(),
                  textStyle: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            BlocBuilder<ExpenseRepeatCubit, ExpenseRepeatState>(
              builder: (context, state) => ExpenseRepeatHeader(
                header: RepeatTypes.values,
                currentIndex: expenseCubit.currentIndex,
                repeatCubit: expenseCubit,
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                child: BlocBuilder<ExpenseRepeatCubit, ExpenseRepeatState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const DetailsText(),
                        SizedBox(height: 2.h),
                        Expanded(
                          child: expenseCubit.getExpenseTypeList().isEmpty
                              ? Image.asset(AppIcons.noDataCate)
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: expenseCubit.getExpenseTypeList().length,
                                  itemBuilder: (context, index) {
                                    final transactionModel =
                                        expenseCubit.getExpenseTypeList()[index];
                                    return TabCardViewEdited(
                                      onPressSeeMore: () => Navigator.push(
                                          context, AppRouter.pageBuilderRoute(
                                         child: StatisticsDetailsScreen(
                                           index: index,
                                           transactions: expenseCubit.getExpenseTypeList(),
                                         )
                                      )),
                                      transaction: transactionModel,
                                      isVisible: true,
                                      isRepeated: false,
                                      priorityName: PriorityType.Important,
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
