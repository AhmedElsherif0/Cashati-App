import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';

import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../constants/app_icons.dart';
import '../../../data/repository/formats_mixin.dart';
import '../../styles/colors.dart';
import '../../widgets/add_income_expense_widget/choose_container.dart';
import '../../widgets/editable_text.dart';
import '../../widgets/expenses_and_income_widgets/important_or_fixed.dart';
import '../../widgets/uneditable_text.dart';

class PartTimeDetails extends StatefulWidget {
  const PartTimeDetails({Key? key, required this.transactionModel}) : super(key: key);
  final TransactionModel transactionModel;

  @override
  State<PartTimeDetails> createState() => _PartTimeDetailsState();
}

class _PartTimeDetailsState extends State<PartTimeDetails>
    with FormatsMixin, HelperClass {
  final TextEditingController mainCategoryController = TextEditingController();
  final TextEditingController calenderController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    mainCategoryController.dispose();
    dateController.dispose();
    amountController.dispose();
    subCategoryController.dispose();
    descriptionController.dispose();
    calenderController.dispose();
    super.dispose();
  }

  AddExpOrIncCubit getAddExpOrIncCubit() => BlocProvider.of<AddExpOrIncCubit>(context);

  void showDatePick() async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (datePicker == null) return;
    getAddExpOrIncCubit().changeDate(datePicker);
  }

  void _onDelete() async {
    final statisticsCubit = BlocProvider.of<StatisticsCubit>(context);
    await statisticsCubit.deleteTransaction(widget.transactionModel);
    statisticsCubit.getExpenses();
    statisticsCubit.getTodayExpenses(true);
  }

  @override
  Widget build(BuildContext context) {
    final txtDirection =
        translator.activeLanguageCode == 'en' ? TextDirection.rtl : TextDirection.ltr;
    return Scaffold(body: SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<StatisticsCubit, StatisticsState>(
          builder: (context, state) {
            return Column(
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
                          EditableInfoField(
                            textEditingController: amountController,
                            hint: currencyFormat(
                                context, widget.transactionModel.amount),
                            iconName: AppIcons.amountIcon,
                            keyboardType: TextInputType.text,
                            trailing: IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                color: AppColor.primaryColor,
                                onPressed: () {
                                  widget.transactionModel.amount =
                                      int.parse(amountController.text);
                                }),
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
                                    _onDelete();
                                    Navigator.of(context).pop();
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
            );
          },
        ),
      ),
    ));
  }
}
