import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/add_income_widget.dart';

import '../../constants/app_icons.dart';
import '../styles/colors.dart';
import '../widgets/add_income_expense_widget/add_expense_widget.dart';

class AddExpenseOrIncomeScreen extends StatefulWidget {
  const AddExpenseOrIncomeScreen({Key? key}) : super(key: key);

  @override
  _AddExpenseOrIncomeScreenState createState() =>
      _AddExpenseOrIncomeScreenState();
}

class _AddExpenseOrIncomeScreenState extends State<AddExpenseOrIncomeScreen> {
  String? subCategoryName;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: currentIndex,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Expense'),
            bottom: TabBar(
                isScrollable: false,
                unselectedLabelColor: AppColor.grey,
                labelColor: AppColor.primaryColor,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15.sp),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15.sp),
                //  padding: EdgeInsets.symmetric(horizontal: 24.0),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColor.primaryColor,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                tabs: const [
                  Tab(child: Text('Expenses')),
                  Tab(child: Text('Income'))
                ]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.notificationSetting))
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: TabBarView(
              children: [
                AddExpenseWidget(),
                AddIncomeWidget(),
              ],
            ),
          )),
    );
  }
}
