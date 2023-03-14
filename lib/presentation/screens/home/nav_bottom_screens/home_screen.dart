import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';
import 'package:temp/presentation/screens/test_screens/general_model_test_screen.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/expenses_income_header.dart';
import '../../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../../business_logic/cubit/home_cubit/home_state.dart';
import '../../../views/card_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //cubit(context).getTheGeneralStatsModel();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context,state){
        if(state is HomeInitial){
          cubit(context).getTheGeneralStatsModel();
        }else if(state is FetchedGeneralModelSuccState||state is ModelExistsSuccState){
          cubit(context).getNotificationList();
        }
      },
      builder: (context, state) {
       if(state is HomeInitial||state is ModelExistsFailState){
         return Center(child: CircularProgressIndicator(),);
       }else{
         return Scaffold(
           body: Column(
             children: [
               const Spacer(flex: 3),

               /// switch between expense and income.
               Expanded(
                 flex: 2,
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 14.0.sp),
                   child: ExpensesAndIncomeHeader(
                       onPressedIncome: () => cubit(context).isExpense
                           ? cubit(context).isItExpense()
                           : null,
                       onPressedExpense: () => !cubit(context).isExpense
                           ? cubit(context).isItExpense()
                           : null,
                       isExpense: cubit(context).isExpense),
                 ),
               ),
               Expanded(
                 flex: 14,
                 child: CardHome(
                   generalStatsModel: cubit(context).generalStatsModel?? GeneralStatsModel
                     (
                     id: AppStrings.theOnlyGeneralStatsModelID,
                       balance: 0,
                       topIncome: 'No Income Added',
                       topIncomeAmount: 0,
                       topExpense: 'No Expense Added',
                       topExpenseAmount: 0,
                       latestCheck: DateTime.now(),
                       notificationList: []),
                   title: cubit(context).isExpense ? 'Expense' : 'Income',
                   onPressedAdd: () => cubit(context).isExpense
                       ? cubit(context).onAddExpense(context)
                       : cubit(context).onAddIncome(context),
                   onPressedShow: cubit(context).isExpense
                       ? cubit(context).onShowExpense
                       : cubit(context).onShowIncome,
                   onPressedTop: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=>GeneralModelTestScreen()));
                   },
                 ),
               ),
               const Spacer(),
             ],
           ),
         );
       }
      },
    );
  }

  HomeCubit cubit(context) => BlocProvider.of<HomeCubit>(context);
}
