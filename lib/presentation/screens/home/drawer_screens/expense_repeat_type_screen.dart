import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/data/repository/helper_class.dart';

import '../../../../business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import '../../../../constants/app_icons.dart';
import '../../../../constants/enum_classes.dart';
import '../../../router/app_router.dart';
import '../../../styles/colors.dart';
import '../../../styles/decorations.dart';
import '../../../views/transaction_card.dart';
import '../../../widgets/common_texts/details_text.dart';
import '../../../widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';

class ExpenseRepeatTypeScreen extends StatelessWidget {
  const ExpenseRepeatTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseCubit = BlocProvider.of<ExpenseRepeatCubit>(context);
    return TransactionRepeatWidget(cubit: expenseCubit, appBarText: 'Expense Repeat');
  }
}

class TransactionRepeatWidget<T> extends StatefulWidget {
  const TransactionRepeatWidget(
      {super.key, required this.cubit, required this.appBarText});

  final T cubit;
  final String appBarText;

  @override
  State<TransactionRepeatWidget> createState() => _TransactionRepeatWidgetState();
}

class _TransactionRepeatWidgetState extends State<TransactionRepeatWidget>
    with HelperClass, TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.animateTo(widget.cubit.currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onSwap({required int index}) {
    tabController.animateTo(index,
        duration: const Duration(milliseconds: 600), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      animationDuration: AppDecorations.duration600ms,
      length: tabController.length,
      initialIndex: tabController.index,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 24.dp,
            padding: EdgeInsets.zero,
            color: AppColor.pineGreen,
            icon: Icon(Icons.arrow_back_ios, size: 24.dp),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.appBarText, style: textTheme.headline3),
          toolbarHeight: 12.h,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.dp),
              child: TabBar(
                onTap: (value) => setState(() => onSwap(index: value)),
                indicatorWeight: 0,
                controller: tabController,
                indicator: AppDecorations.defBoxDecoration,
                unselectedLabelColor: AppColor.grey,
                isScrollable: true,
                tabs: List.generate(RepeatTypes.values.length, (index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 25.w,
                        height: 6.h,
                        child: TabBarItem(
                          text: RepeatTypes.values[index].name,
                          onTap: () => setState(() => onSwap(index: index)),
                          textColor: (tabController.index == index)
                              ? AppColor.white
                              : AppColor.primaryColor,
                          backGroundColor: tabController.index == index
                              ? AppColor.primaryColor
                              : AppColor.white,
                        ),
                      ),
                    ],
                  );
                }, growable: false),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 1.h),
            const DetailsText(),
            SizedBox(height: 2.h),
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  tabController.length,
                  (generateIndex) {
                    return widget.cubit.getRepeatTransactions(generateIndex).isEmpty
                        ? Image.asset(AppIcons.noDataCate)
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: widget.cubit
                                .getRepeatTransactions(generateIndex).length,
                            itemBuilder: (context, indexBuilder) => TransactionCardView(
                              onPressSeeMore: () => Navigator.push(
                                context,
                                AppRouter.pageBuilderRoute(
                                  child: onPressDetails(
                                      generateIndex,
                                      widget.cubit
                                          .getRepeatTransactions(generateIndex),
                                      indexBuilder),
                                ),
                              ),
                              transaction: widget.cubit
                                  .getRepeatTransactions(generateIndex)[indexBuilder],
                              isVisible: true,
                              priorityName: PriorityType.Important,
                            ),
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
