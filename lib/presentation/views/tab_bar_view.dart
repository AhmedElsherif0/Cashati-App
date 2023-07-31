import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/views/transaction_card.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/tab_view_item_decoration.dart';

import '../../constants/app_icons.dart';
import '../../constants/enum_classes.dart';
import '../../data/repository/helper_class.dart';
import '../styles/decorations.dart';
import '../widgets/common_texts/details_text.dart';

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
  final void Function(int) onPressSeeMore;

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
    return DefaultTabController(
      animationDuration: AppDecorations.duration600ms,
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
            labelStyle: Theme.of(context).textTheme.headline5,
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
                                  return TransactionCardView(
                                    onPressSeeMore: () => widget.onPressSeeMore(index),
                                    isVisible: true,
                                    isRepeated: 'No Repeat' !=
                                            widget.transactions[index].repeatType
                                        ? true
                                        : false,
                                    transaction: widget.transactions[index],
                                  );
                                },
                              );
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
