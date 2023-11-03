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

class PartTimeDetails extends StatefulWidget {
  const PartTimeDetails({Key? key, required this.transactionModel}) : super(key: key);
  final TransactionModel transactionModel;

  @override
  State<PartTimeDetails> createState() => _PartTimeDetailsState();
}

class _PartTimeDetailsState extends State<PartTimeDetails>
    with AlertDialogMixin, FormatsMixin, HelperClass {
  void _onDelete(bool isExpense) async {
    final statisticsCubit = BlocProvider.of<StatisticsCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    await statisticsCubit.deleteTransaction(widget.transactionModel);

    if (isExpense) {
      await _getRepeatTransactions(BlocProvider.of<ExpenseRepeatCubit>(context));
    } else {
      await _getRepeatTransactions(BlocProvider.of<IncomeRepeatCubit>(context));
    }

    BlocProvider.of<StatisticsCubit>(context).getExpenses();
    BlocProvider.of<StatisticsCubit>(context).getTodayExpenses(true);

    homeCubit.onRemoveNotificationForDeletedTransaction(widget.transactionModel.name);
    homeCubit.getNotificationList();
  }

  Future<void> _getRepeatTransactions(repeatCubit) async {
    for (int i = 0; i <= 3; i++) {
      await repeatCubit.getRepeatTransactions(i);
    }
    repeatCubit.refreshData();
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
                    title: widget.transactionModel.isExpense
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
                            hint: widget.transactionModel.name,
                            iconName: AppIcons.home,
                          ),
                          SizedBox(height: 15.dp),
                          SizedBox(
                              width: 90.w,
                              child: DateChooseContainer(
                                onTap: () {},
                                dateTime: widget.transactionModel.createdDate,
                              )),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: widget.transactionModel.mainCategory.tr(),
                            iconName: AppIcons.categoryIcon,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: widget.transactionModel.subCategory.tr(),
                            iconName: AppIcons.categories,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: currencyFormat(
                                context, widget.transactionModel.amount),
                            iconName: AppIcons.amountIcon,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            hint: widget.transactionModel.repeatType.tr(),
                            iconName: AppIcons.change,
                          ),
                          SizedBox(height: 15.dp),
                          UnEditableInfoField(
                            header: AppStrings.description.tr(),
                            hint: widget.transactionModel.description == ''
                                ? AppStrings.subDescription.tr()
                                : widget.transactionModel.description,
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
                                        message: getMsg(widget.transactionModel.name),
                                        onYes: () {
                                          _onDelete(widget.transactionModel.isExpense);
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
                                      color: widget.transactionModel.isPriority
                                          ? AppColor.secondColor
                                          : AppColor.pinkishGrey,
                                      text: priorityNames(
                                          widget.transactionModel.isExpense,
                                          widget.transactionModel.isPriority),
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
