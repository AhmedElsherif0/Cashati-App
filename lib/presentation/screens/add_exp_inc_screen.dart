import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/add_income_widget.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';

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
          body:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 5.h,),
                CustomAppBar(title:'Add Transaction',
                onTapNotification: () {
                  Navigator.pushNamed(context, AppRouterNames.rAddSubCategory);
                },
                ),
                SizedBox(height: 1.h,),
                TabBar(
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

                Expanded(
                  child: TabBarView(
                    children: [
                      AddExpenseWidget(),
                      AddIncomeWidget(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
  /*
  old app bar
    appBar: AppBar(
            title: const Text('Add Expense'),
            leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back)),
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
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterNames.rAddSubCategory);
                  },
                  icon: SvgPicture.asset(AppIcons.notificationSetting))
            ],
          ),
   */
}
