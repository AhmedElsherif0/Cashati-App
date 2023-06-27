import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/router/app_router.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/income_repeat_header.dart';

import '../../../../business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import '../../../../constants/app_icons.dart';
import '../../../../constants/enum_classes.dart';
import '../../../views/tab_bar_view.dart';
import '../../../widgets/common_texts/details_text.dart';
import '../statistics_details_screen.dart';

class IncomeRepeatTypeScreen extends StatelessWidget {
  const IncomeRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incomeCubit = BlocProvider.of<IncomeRepeatCubit>(context);

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
                header: RepeatTypes.values,
                currentIndex: incomeCubit.currentIndex,
                incomeRepeatCubit: incomeCubit,
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
                          child: incomeCubit.getIncomeTypeList().isEmpty
                              ? Image.asset(AppIcons.noDataCate)
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: incomeCubit.getIncomeTypeList().length,
                                  itemBuilder: (context, index) {
                                    final transactionModel =
                                        incomeCubit.getIncomeTypeList()[index];
                                    return TabCardViewEdited(
                                      onPressSeeMore: () => Navigator.push(
                                          context,
                                          AppRouter.pageBuilderRoute(
                                              child: StatisticsDetailsScreen(
                                            index: index,
                                            transactions:
                                                incomeCubit.getIncomeTypeList(),
                                          ))),
                                      transaction: transactionModel,
                                      isVisible: true,
                                      isRepeated: false,
                                      priorityName: PriorityType.Important,
                                    );
                                  },
                                ),
                        )
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
