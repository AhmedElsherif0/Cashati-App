import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/expenses_income_header.dart';
import '../../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../../business_logic/cubit/home_cubit/home_state.dart';
import '../../../views/card_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
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
                  title: cubit(context).isExpense ? 'Expense' : 'Income',
                  onPressedAdd: cubit(context).isExpense
                      ? cubit(context).onAddExpense
                      : cubit(context).onAddIncome,
                  onPressedShow: cubit(context).isExpense
                      ? cubit(context).onShowExpense
                      : cubit(context).onShowIncome,
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  HomeCubit cubit(context) => BlocProvider.of<HomeCubit>(context);

  Widget missingWidget(cubit, textTheme) {
    return Column(
      children: [
        cubit.isSelect
            ? CardHome(
                title: "Expenses",
                onPressedAdd: () {},
                onPressedShow: () {},
              )
            : CardHome(
                title: 'Income',
                onPressedAdd: () {},
                onPressedShow: () {},
              )
      ],
    );
  }
}
