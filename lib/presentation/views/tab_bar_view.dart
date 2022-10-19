import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expenses_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/tab_card_View.dart';

import 'package:temp/presentation/widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';

import '../../constants/enum_classes.dart';

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    Key? key,
    required this.currentIndex,
    required this.expensesList,
    required this.index,
    required this.pageController,
    required this.priorityName,
  }) : super(key: key);

  final int currentIndex;
  final String priorityName;
  final int index;
  final List<ExpensesModel> expensesList;
  final PageController pageController;

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  late TabController tabController;

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
    String currentTime =
        DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    const duration600ms = Duration(milliseconds: 600);
    return DefaultTabController(
      animationDuration: duration600ms,
      length: 3,
      initialIndex: widget.pageController.initialPage,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                widget.pageController.animateToPage(
                  tabController.index,
                  duration: duration600ms,
                  curve: Curves.easeOut,
                );
              });
            },
            controller: tabController,
            indicator: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(width: 1.sp, color: AppColor.primaryColor),
            ),
            unselectedLabelColor: AppColor.primaryColor,
            labelStyle: Theme.of(context).textTheme.headline6,
            tabs: [
              Tab(
                  height: 6.h,
                  child: TabBarItem(text: widget.expensesList[0].header)),
              Tab(
                  height: 6.h,
                  child: TabBarItem(text: widget.expensesList[1].header)),
              Tab(
                  height: 6.h,
                  child: TabBarItem(text: widget.expensesList[2].header)),
            ],
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Details', style: Theme.of(context).textTheme.headline3),
            ),
            const Spacer(),
            Expanded(
              flex: 32,
              child: TabBarView(
                controller: tabController,
                children: [
                  /// Daily List of Details Card
                  TabCardView(
                    priorityName: widget.priorityName,
                    expensesName: widget.expensesList[0].header,
                    listItem: [31, 12, 13],
                    isPriority: widget.expensesList[0].isImportant,
                    onPressSeeMore: () {},
                    dateTime: currentTimeAfter,
                    price: '${widget.expensesList[0].price}',
                    isVisible: true,
                    seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                  ),

                  /// Weekly List of Details Card
                  TabCardView(
                    priorityName: widget.priorityName,
                    expensesName: widget.expensesList[1].header,
                    listItem: [1, 2, 3, 4],
                    isPriority: widget.expensesList[1].isImportant,
                    onPressSeeMore: () {},
                    dateTime: 'From $currentTime To $currentTimeAfter',
                    price: '${widget.expensesList[1].price}',
                    isVisible: true,
                    seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                  ),
                  /// Monthly List of Details Card
                  TabCardView(
                    priorityName: widget.priorityName,
                    expensesName: widget.expensesList[2].header,
                    listItem: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                    isPriority: widget.expensesList[2].isImportant,
                    onPressSeeMore: () {},
                    dateTime: currentTimeAfter,
                    price: '${widget.expensesList[2].price}',
                    isVisible: true,
                    seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
