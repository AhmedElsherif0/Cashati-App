import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/tab_card_view.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';
import '../../constants/enum_classes.dart';
import '../../data/models/statistics/expenses_lists.dart';
import '../styles/decorations.dart';
import '../widgets/common_texts/details_text.dart';

class CustomTabBarViewEdited extends StatefulWidget {
  const CustomTabBarViewEdited({
    Key? key,
    this.expenseList = const [],
    required this.index,
    this.pageController,
    required this.priorityName,
    required this.monthWidget,
    required this.onPressSeeMore,
    this.transactionDetails = const [],
  }) : super(key: key);

  final PriorityType priorityName;
  final int index;
  final List<TransactionModel>? expenseList;
  final List<TransactionRepeatDetailsModel>? transactionDetails;
  final PageController? pageController;
  final Widget monthWidget;
  final void Function() onPressSeeMore;

  @override
  State<CustomTabBarViewEdited> createState() => _CustomTabBarViewEditedState();
}

class _CustomTabBarViewEditedState extends State<CustomTabBarViewEdited>
    with TickerProviderStateMixin {
  late TabController tabController;

  void onSwapByIndex({required int index}) {
    widget.pageController?.animateToPage(index,
        duration: const Duration(milliseconds: 600), curve: Curves.easeOut  );
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
    ExpensesLists expensesLists = ExpensesLists();
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
            tabs: List.generate(expensesLists.statisticsList.length, (index) {
              return TabBarItem(
                text: expensesLists.statisticsList[index],
                onTap: () => setState(() => onSwapByIndex(index: index)),
                textColor: tabController.index == index
                    ? AppColor.white
                    : AppColor.primaryColor,
                backGroundColor: tabController.index == index
                    ? AppColor.primaryColor
                    : AppColor.white,
              );
            }),
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
                      children: List.generate(
                        tabController.length,
                        (index) => TabCardViewEdited(
                          seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                          isVisible: true,
                          transactions: widget.expenseList ?? [],
                          onPressSeeMore: widget.onPressSeeMore,
                        ),
                      ),
                    ),
                  )
                : Expanded(flex: 44, child: widget.monthWidget),
          ],
        ),
      ),
    );
  }
}
