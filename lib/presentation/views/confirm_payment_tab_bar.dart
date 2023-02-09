import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/presentation/widgets/tab_bar_icon_text.dart';
import '../../constants/app_icons.dart';
import '../styles/colors.dart';

class ConfirmPaymentTabBar extends StatefulWidget {
  const ConfirmPaymentTabBar({Key? key}) : super(key: key);

  @override
  State<ConfirmPaymentTabBar> createState() => _ConfirmPaymentTabBarState();
}

class _ConfirmPaymentTabBarState extends State<ConfirmPaymentTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _controller = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> _iconList(index) =>
      [AppIcons.expense, AppIcons.incomeDrawer, AppIcons.goals];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TabBar(
      tabs: List.generate(
        3,
        (index) => TabBarIconText(
            svgIcon: _iconList(index)[index],
            transactionType: TransactionType.values[index],
            isClicked: _controller.index == index),
        growable: false,
      ),
      onTap: (index) => setState(() => _controller.index == index),
      indicatorWeight: 2.sp,
      controller: _controller,
      labelStyle: textTheme.headline6,
      unselectedLabelColor: AppColor.pinkishGrey,
      indicatorColor: AppColor.primaryColor,
      dividerColor: AppColor.primaryColor,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}
