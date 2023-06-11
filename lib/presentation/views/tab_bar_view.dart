import 'package:easy_localization/easy_localization.dart';
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

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    Key? key,
    required this.currentIndex,
    required this.expenseDetailsList,
    required this.index,
    required this.pageController,
    required this.priorityName,
  }) : super(key: key);

  final int currentIndex;
  final PriorityType priorityName;
  final int index;
  final List<TransactionRepeatDetailsModel> expenseDetailsList;
  final PageController pageController;

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  late TabController tabController;

  void onSwapByIndex({required int index}) {
    widget.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
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
      initialIndex: widget.pageController.initialPage,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) => setState(() => onSwapByIndex(index: value)),
            indicatorWeight: 0,
            controller: tabController,
            indicator: AppDecorations.defBoxDecoration,
            unselectedLabelColor: AppColor.primaryColor,
            labelStyle: Theme.of(context).textTheme.headline6,
            tabs: List.generate(3, (index) {
              return Tab(
                height: 6.h,
                child: TabBarItem(
                  text: expensesLists.statisticsList[index],
                  onTap: () => setState(() => onSwapByIndex(index: index)),
                  textColor: tabController.index == index
                      ? AppColor.white
                      : AppColor.primaryColor,
                  backGroundColor: tabController.index == index
                      ? AppColor.primaryColor
                      : AppColor.white,
                ),
              );
            }),
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            const DetailsText(),
            const Spacer(),
            Expanded(
              flex: 44,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: List.generate(
                    expensesLists.noRepeats.length - 1, (index) => SizedBox()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBarViewEdited extends StatefulWidget {
  const CustomTabBarViewEdited({
    Key? key,
    required this.currentIndex,
    required this.expenseList,
    required this.index,
    required this.pageController,
    required this.priorityName,
    required this.monthWidget,
    required this.onPressSeeMore,
  }) : super(key: key);

  final int currentIndex;
  final PriorityType priorityName;
  final int index;
  final List<TransactionModel> expenseList;
  final PageController pageController;
  final Widget monthWidget;
  final void Function() onPressSeeMore;

  @override
  State<CustomTabBarViewEdited> createState() => _CustomTabBarViewEditedState();
}

class _CustomTabBarViewEditedState extends State<CustomTabBarViewEdited>
    with TickerProviderStateMixin {
  late TabController tabController;

  void onSwapByIndex({required int index}) {
    widget.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
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
      initialIndex: widget.pageController.initialPage,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) => setState(() => onSwapByIndex(index: value)),
            indicatorWeight: 0,
            controller: tabController,
            indicator: AppDecorations.defBoxDecoration,
            unselectedLabelColor: AppColor.grey,
            labelStyle: Theme.of(context).textTheme.headline6,
            tabs: List.generate(3, (index) {
              return Tab(
                height: 6.h,
                child: TabBarItem(
                  text: expensesLists.statisticsList[index],
                  onTap: () => setState(() => onSwapByIndex(index: index)),
                  textColor: tabController.index == index
                      ? AppColor.white
                      : AppColor.primaryColor,
                  backGroundColor: tabController.index == index
                      ? AppColor.primaryColor
                      : AppColor.white,
                ),
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
                        expensesLists.noRepeats.length - 1,
                        (index) => TabCardViewEdited(
                          seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                          isVisible: true,
                          expenseList: widget.expenseList,
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
