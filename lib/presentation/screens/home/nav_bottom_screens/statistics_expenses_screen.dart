import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/views/flow_chart_view.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import '../../../../constants/enum_classes.dart';
import '../../../../data/models/statistics/expenses_lists.dart';
import '../../../styles/colors.dart';
import '../../../views/tab_bar_view.dart';

class ExpensesStatisticsScreen extends StatefulWidget {
  const ExpensesStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesStatisticsScreen> createState() =>
      _ExpensesStatisticsScreenState();
}

class _ExpensesStatisticsScreenState extends State<ExpensesStatisticsScreen> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getStatisticsCubit().getExpenses() ;
    getStatisticsCubit().getExpenseByMonth() ;
  }

  StatisticsCubit getStatisticsCubit() =>
      BlocProvider.of<StatisticsCubit>(context);

  void showDatePick() async {

    final datePicker = await showDatePicker(
      context: context,
      initialDate: getStatisticsCubit().choosenDay,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      // initialDatePickerMode: DatePickerMode.year,
      // initialEntryMode: DatePickerEntryMode.calendarOnly,

    );
    if (datePicker == null){
      return;
    }else{
      getStatisticsCubit().getExpensesByDay(datePicker);

    }
    // getStatisticsCubit().choosenDay = datePicker;
  }
  void showDatePickMonth() async {

    final datePicker = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
      //initialMonthYearPickerMode: MonthYearPickerMode.year
    );
    if (datePicker == null){
      return;
    }else{
      getStatisticsCubit().getExpensesByDay(datePicker);

    }
    // getStatisticsCubit().choosenDay = datePicker;
  }

  @override
  Widget build(BuildContext context) {
    ExpensesLists expensesLists = ExpensesLists();
    int currentIndex = 0;
    return Scaffold(
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemCount: 3,
              itemBuilder: (context, index) {
                final list = expensesLists.expensesData[index];
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            if(index==0){
                              showDatePick();
                            }else{
                              showDatePickMonth();
                            }
                          },
                          text:
                          index==0? '${getStatisticsCubit().choosenDay.day} \\ ${getStatisticsCubit().choosenDay.month} \\ ${getStatisticsCubit().choosenDay.year}':"${getStatisticsCubit().choosenDay.month} \\ ${getStatisticsCubit().choosenDay.year}",
                          textStyle: Theme.of(context).textTheme.subtitle1,
                          backgroundColor: AppColor.white,
                          width: 40.w,
                          borderRadius: 8.sp,
                        ),
                        const Spacer(),
                        FlowChartView(
                            index: index,
                            priorityType: PriorityType.Important,
                            notPriority: PriorityType.NotImportant,
                            expensesModel: list),

                        /// TabBarView Widgets.
                        ///Todo:: taken a different list verses the ExpenseList.
                        Expanded(
                          flex: 40,
                          child: CustomTabBarViewEdited(
                              priorityName: PriorityType.Important,
                              expenseList: getStatisticsCubit().byDayList,
                              monthWidget: ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (ctx,ind){
                                return ExpansionTile(
                                  title: Text("Week ${ind + 1}"),
                                  subtitle:
                                  Text("${getStatisticsCubit().totals[ind]}"),
                                );
                              }),
                              currentIndex: currentIndex,
                              index: index,
                              pageController: _controller),
                        ),
                        // Expanded(
                        //     flex: 40,
                        //     child:
                        //         ListView.builder(
                        //             itemCount: getStatisticsCubit().currentIndex==0?getStatisticsCubit().byDayList.length:3,
                        //             itemBuilder: (context, index) {
                        //               TransactionModel item =getStatisticsCubit().byDayList[index];
                        //       return Visibility(
                        //         visible: getStatisticsCubit().currentIndex==0,
                        //           child: ExpansionTile(
                        //               title: Text(item.name),
                        //               children: [
                        //                 Text('${item.paymentDate}'),
                        //               ]
                        //
                        //           ),
                        //       replacement: ExpansionTile(title: Text("Week ${index+1}"),
                        //       subtitle: Text("${getStatisticsCubit().totals[index]}"),
                        //       ),
                        //       );
                        //     })
                        //
                        //
                        //
                        //     ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
