import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';

import '../../constants/app_icons.dart';
import '../../constants/enum_classes.dart';
import '../../data/repository/helper_class.dart';
import '../styles/decorations.dart';
import '../widgets/common_texts/details_text.dart';
import '../widgets/expenses_and_income_widgets/important_or_fixed.dart';

class CustomTabBarViewEdited extends StatefulWidget {
  const CustomTabBarViewEdited({
    Key? key,
    this.transactions = const [],
    required this.index,
    this.pageController,
    required this.priorityName,
    required this.monthWidget,
    required this.onPressSeeMore,
  }) : super(key: key);

  final PriorityType priorityName;
  final int index;
  final List<TransactionModel> transactions;
  final PageController? pageController;
  final Widget monthWidget;
  final void Function() onPressSeeMore;

  @override
  State<CustomTabBarViewEdited> createState() => _CustomTabBarViewEditedState();
}

class _CustomTabBarViewEditedState extends State<CustomTabBarViewEdited>
    with TickerProviderStateMixin, HelperClass {
  late TabController tabController;

  void onSwapByIndex({required int index}) {
    widget.pageController?.animateToPage(index,
        duration: const Duration(milliseconds: 600), curve: Curves.easeOut);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(widget.index);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ExpensesLists expensesLists = ExpensesLists();
    const duration600ms = Duration(milliseconds: 600);
    return DefaultTabController(
      animationDuration: duration600ms,
      length: 3,
      initialIndex: widget.pageController!.initialPage,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1.h,
          bottom: TabBar(
            onTap: (value) => setState(() => onSwapByIndex(index: value)),
            indicatorWeight: 0,
            controller: tabController,
            indicator: AppDecorations.defBoxDecoration,
            unselectedLabelColor: AppColor.grey,
            labelStyle: Theme.of(context).textTheme.headline6,
            tabs: List.generate(
              StatisticsHeader.values.length,
              (index) => TabBarItem(
                text: StatisticsHeader.values[index].name,
                onTap: () => setState(() => onSwapByIndex(index: index)),
                textColor: tabController.index == index
                    ? AppColor.white
                    : AppColor.primaryColor,
                backGroundColor: tabController.index == index
                    ? AppColor.primaryColor
                    : AppColor.white,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            const DetailsText(),
            const Spacer(),
            widget.index == 0
                ? Expanded(
                    flex: 44,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: List.generate(tabController.length, (index) {
                        return widget.transactions.isEmpty
                            ? Image.asset(AppIcons.noDataCate)
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: widget.transactions.length,
                                itemBuilder: (context, index) {
                                  return TabCardViewEdited(
                                    onPressSeeMore: widget.onPressSeeMore,
                                    isVisible: true,
                                    transaction: widget.transactions[index],
                                  );
                                });
                      }),
                    ),
                  )
                : Expanded(flex: 44, child: widget.monthWidget),
          ],
        ),
      ),
    );
  }
}

class TabCardViewEdited extends StatelessWidget with HelperClass {
  const TabCardViewEdited(
      {Key? key,
      required this.transaction,
      required this.onPressSeeMore,
      this.priorityName = PriorityType.Important,
      required this.isVisible,
      this.seeMoreOrDetailsOrHighest,
      this.isRepeated = false,
      this.priorityColor = AppColor.secondColor})
      : super(key: key);

  final bool isVisible;
  final bool isRepeated;
  final TransactionModel transaction;
  final PriorityType priorityName;
  final Color priorityColor;
  final void Function() onPressSeeMore;
  final SwitchWidgets? seeMoreOrDetailsOrHighest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          elevation: 4.sp,
          color: AppColor.lightGrey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text(transaction.name,
                          overflow: TextOverflow.ellipsis, style: textTheme.headline5),
                    ),
                    Text(
                      '${transaction.amount} LE',
                      style: textTheme.headline5?.copyWith(
                          color: transaction.isExpense
                              ? AppColor.red
                              : AppColor.secondColor),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatDayDate(transaction.createdDate),
                    style: textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: isRepeated,
                          child: Column(
                            children: [
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(transaction.repeatType,
                                    style: textTheme.subtitle1),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isVisible,
                          child: switchWidgets(
                              onPress: onPressSeeMore,
                              switchWidgets: SwitchWidgets.seeMore,
                              transaction: transaction),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Spacer(),
                          PriorityWidget(
                            color: transaction.isPriority
                                ? AppColor.secondColor
                                : AppColor.pinkishGrey,
                            text: priorityNames(
                                transaction.isExpense, transaction.isPriority),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 3.h)
      ],
    );
  }
}
