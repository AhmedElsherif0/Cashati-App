import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expense_model.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/views/tab_card_view.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import 'package:temp/presentation/widgets/expense_repeat_header.dart';
import '../../../../business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import '../../../../constants/enum_classes.dart';
import '../../../styles/colors.dart';
import '../../../widgets/details_text.dart';
import '../../../widgets/expenses_and_income_widgets/important_or_fixed.dart';
import '../../../widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';
import '../../../widgets/expenses_and_income_widgets/underline_text_button.dart';

class ExpenseRepeatTypeScreen extends StatelessWidget {
  const ExpenseRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            /// Custom AppBar.
            _appBarWidget(context),
            BlocBuilder<ExpenseRepeatCubit, ExpenseRepeatState>(
              builder: (context, state) => ExpenseRepeatHeader(
                header: _repeatCubit(context).noRepeats,
                currentIndex: _repeatCubit(context).currentIndex,
                repeatCubit: _repeatCubit(context),
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
                          child: TabCardView(
                            priorityName: 'Important',
                            expenseRepeatList:
                                _repeatCubit(context).getExpenseTypeList(),
                            onPressSeeMore: () => Navigator.of(context)
                                .pushNamed(
                                    AppRouterNames.rExpenseRepeatDetails),
                            isVisible: true,
                            isRepeated: true,
                            seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
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

  ExpenseRepeatCubit _repeatCubit(context) =>
      BlocProvider.of<ExpenseRepeatCubit>(context);

  Widget _appBarWidget(BuildContext context) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: CustomAppBar(
            title: 'Expense Repeat Income',
            onTapFirstIcon: ()=> Navigator.of(context).pop(),
            onTanNotification: () {},
            textStyle: Theme.of(context).textTheme.headline5,
          ),
        ),
      );
}
