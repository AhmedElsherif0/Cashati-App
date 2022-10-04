import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/tab_body_daily_view.dart';
import 'package:temp/presentation/widgets/tab_view_item_decoration.dart';

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView(
      {Key? key, required this.currentIndex, required this.onTapTabBar})
      : super(key: key);
  final int currentIndex;
  final void Function(int) onTapTabBar;

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  /* late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(2);
  }*/

  @override
  Widget build(BuildContext context) {
    String currentTime =
        DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 300),
      // list.length
      length: 3,
      initialIndex: widget.currentIndex,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: widget.onTapTabBar,
            indicator: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12.sp),
                border: Border.all(width: 1.sp, color: AppColor.primaryColor)),
            unselectedLabelColor: AppColor.primaryColor,
            labelStyle: Theme.of(context).textTheme.headline6,
            tabs: const [
              Tab(child: TabBarItem(text: 'Daily')),
              Tab(child: TabBarItem(text: 'Weekly')),
              Tab(child: TabBarItem(text: 'Monthly')),
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
              flex: 20,
              child: TabBarView(
                children: [
                  TabBodyView(
                    isListIsEmpty: false,
                    expensesName: 'Daily',
                    listItemCount: 31,
                    isImportant: true,
                    onPressSeeMore: () {},
                    dateTime: currentTimeAfter,
                    price: '200',
                  ),
                  TabBodyView(
                    isListIsEmpty: false,
                    expensesName: 'Weekly',
                    listItemCount: 4,
                    isImportant: false,
                    onPressSeeMore: () {},
                    dateTime: currentTimeAfter,
                    price: '200',
                  ),
                  TabBodyView(
                    isListIsEmpty: false,
                    expensesName: 'Monthly',
                    listItemCount: 12,
                    isImportant: false,
                    onPressSeeMore: () {},
                    dateTime: currentTimeAfter,
                    price: '200',
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
