import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/expenses/expense_details_model.dart';
import 'package:temp/data/models/expenses/expense_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/tab_card_View.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';
import '../../constants/enum_classes.dart';
import '../widgets/details_text.dart';

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
  final List<ExpenseRepeatDetailsModel> expensesList;
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
            indicatorWeight: 0,
            controller: tabController,
            indicator: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(width: 1.sp, color: AppColor.primaryColor),
            ),
            unselectedLabelColor: AppColor.primaryColor,
            labelStyle: Theme.of(context).textTheme.headline6,
            tabs: List.generate(
              3,
              (index) => Tab(
                height: 6.h,
                child: TabBarItem(
                    text: widget.expensesList[index].expenseModel.name,
                    onTap: () {}),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            const DetailsText(),
            const Spacer(),
         /*   Expanded(
              flex: 44,
              child: TabBarView(
                controller: tabController,
                children: List.generate(
                  3,
                  (index) => TabCardView(
                    priorityName: widget.priorityName,
                    expensesName: widget.expensesList[index].expenseModel.name,
                    listItem: widget.expensesList,
                    isPriority:
                        widget.expensesList[index].expenseModel.isPriority,
                    dateTime: currentTimeAfter,
                    price: '${widget.expensesList[index].expenseModel.amount}',
                    seeMoreOrDetailsOrHighest: SwitchWidgets.seeMore,
                    onPressSeeMore: () {},
                    isVisible: true,
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
