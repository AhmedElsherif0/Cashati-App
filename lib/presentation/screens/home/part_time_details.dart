import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/expense_repeat/expense_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/business_logic/cubit/income_repeat/income_repeat_cubit.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/views/custom_app_bar.dart';

import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../constants/app_icons.dart';
import '../../../data/repository/formats_mixin.dart';
import '../../styles/colors.dart';
import '../../widgets/add_income_expense_widget/choose_container.dart';
import '../../widgets/expenses_and_income_widgets/important_or_fixed.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/uneditable_text.dart';

class PartTimeDetails extends StatelessWidget
    with AlertDialogMixin, FormatsMixin, HelperClass {
  const PartTimeDetails({Key? key, required this.transactionModel}) : super(key: key);
  final TransactionModel transactionModel;

  Future<void> _onDelete(BuildContext context, bool isExpense) async {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    await context.read<StatisticsCubit>().deleteTransaction(transactionModel);

    await _getAllData(context, isExpense);

    homeCubit.onRemoveNotificationForDeletedTransaction(transactionModel.name);
    homeCubit.getNotificationList();
  }

  Future<void> _getAllData(BuildContext context, bool isExpense) async {
    BlocProvider.of<StatisticsCubit>(context).getExpenses();
    BlocProvider.of<StatisticsCubit>(context).getTodayExpenses(true);

    if (isExpense) {
      await context.read<ExpenseRepeatCubit>().getAllRepeatTransactions();
    } else {
      await context.read<IncomeRepeatCubit>().getAllRepeatTransactions();
    }

    context.read<HomeCubit>().getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    final txtDirection =
        translator.activeLanguageCode == 'en' ? TextDirection.rtl : TextDirection.ltr;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<StatisticsCubit, StatisticsState>(
            builder: (context, state) => Column(
              children: [
                SizedBox(height: 15.dp),
                CustomAppBar(
                    title: transactionModel.isExpense
                        ? AppStrings.expenseDetails.tr()
                        : AppStrings.incomeDetails.tr(),
                    isEndIconVisible: false),
                SizedBox(height: 40.dp),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          UnEditableInfoField(
                            hint: transactionModel.name,
                            iconName: AppIcons.home,
                          ),
                          SizedBox(height: 15.dp),
                          SizedBox(
                              width: 90.w,
                              child: DateChooseContainer(
                                onTap: () {},
                                dateTime: transactionModel.createdDate,
                              )),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: transactionModel.mainCategory.tr(),
                            iconName: AppIcons.categoryIcon,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: transactionModel.subCategory.tr(),
                            iconName: AppIcons.categories,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: currencyFormat(context, transactionModel.amount),
                            iconName: AppIcons.amountIcon,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: transactionModel.repeatType.tr(),
                            iconName: AppIcons.change,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            header: AppStrings.description.tr(),
                            hint: transactionModel.description == ''
                                ? AppStrings.subDescription.tr()
                                : transactionModel.description,
                            iconName: '',
                          ),
                          SizedBox(height: 30.dp),
                          Row(
                            textDirection: txtDirection,
                            children: [
                              const Expanded(child: SizedBox.shrink()),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showYesOrNoDialog(
                                        title: AppStrings.deleteExpense.tr(),
                                        message: getMsg(transactionModel.name),
                                        onYes: () {
                                          _onDelete(
                                              context, transactionModel.isExpense);
                                          Navigator.of(context).pop();
                                        },
                                        context: context);
                                  },
                                  child: CircleAvatar(
                                    radius: 16.dp,
                                    backgroundColor: AppColor.primaryColor,
                                    child: SvgPicture.asset(AppIcons.delete,
                                        color: AppColor.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  textDirection: txtDirection,
                                  children: [
                                    const Spacer(),
                                    PriorityWidget(
                                      color: transactionModel.isPriority
                                          ? AppColor.secondColor
                                          : AppColor.pinkishGrey,
                                      text: priorityNames(transactionModel.isExpense,
                                          transactionModel.isPriority),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
