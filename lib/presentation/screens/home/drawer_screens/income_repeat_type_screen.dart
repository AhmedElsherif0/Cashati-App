import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/views/tab_card_view.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/income_repeat_header.dart';

import '../../../../business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import '../../../../constants/enum_classes.dart';
import '../../../widgets/common_texts/details_text.dart';

class IncomeRepeatTypeScreen extends StatelessWidget {
  const IncomeRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  title: 'Income Repeat ',
                  onTapFirstIcon: () => Navigator.of(context).pop(),
                  textStyle: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            BlocBuilder<IncomeRepeatCubit, IncomeRepeatCubitStates>(
              builder: (context, state) => IncomeRepeatHeader(
                header: _repeatCubit(context).noRepeats,
                currentIndex: _repeatCubit(context).currentIndex,
                incomeRepeatCubit: _repeatCubit(context),
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                child: BlocBuilder<IncomeRepeatCubit, IncomeRepeatCubitStates>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const DetailsText(),
                        SizedBox(height: 2.h),
                        Expanded(
                          child: TabCardView(
                            priorityName: PriorityType.Fixed,
                            expenseRepeatList:
                                _repeatCubit(context).getIncomeTypeList(),
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

  IncomeRepeatCubit _repeatCubit(context) =>
      BlocProvider.of<IncomeRepeatCubit>(context);
}
