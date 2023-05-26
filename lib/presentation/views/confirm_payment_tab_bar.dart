import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/enum_classes.dart';
import 'package:temp/presentation/widgets/tab_bar_icon_text.dart';
import '../../constants/app_icons.dart';
import '../styles/colors.dart';

class ConfirmPaymentTabBar extends StatefulWidget {
   ConfirmPaymentTabBar({Key? key, required this.tabBarIndex, required this.onChangeIndex}) : super(key: key);
   late int tabBarIndex ;
   final Function(int index) onChangeIndex;

  @override
  State<ConfirmPaymentTabBar> createState() => _ConfirmPaymentTabBarState();
}

class _ConfirmPaymentTabBarState extends State<ConfirmPaymentTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _controller = TabController(length: 3, vsync: this);


  @override
  void initState() {
    // TODO: implement initState
    _controller.index=widget.tabBarIndex;
    super.initState();
  }

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
      onTap: (index) {
        widget.onChangeIndex(index);
        // setState(() => _controller.index == index);
        // widget.tabBarIndex = index;
      },
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
