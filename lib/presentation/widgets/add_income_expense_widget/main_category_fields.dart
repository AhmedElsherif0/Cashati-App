import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/custom_check_box.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/sub_category_fields.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../constants/app_icons.dart';
import '../../../data/local/hive/id_generator.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../../data/models/transactions/transaction_model.dart';
import '../../styles/colors.dart';
import '../buttons/elevated_button.dart';
import '../dorp_downs_buttons/goals_drop_down.dart';
import '../editable_text.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

class MainCategoryFields extends StatefulWidget {
  const MainCategoryFields({
    super.key,
    required this.addExpOrIncCubit,
    required this.icons,
    required this.mainCategoryName,
    required this.subCategoriesList,
  });

  final AddExpOrIncCubit addExpOrIncCubit;
  final String icons;
  final String mainCategoryName;
  final List<SubCategory> subCategoriesList;

  @override
  State<MainCategoryFields> createState() => _MainCategoryFieldsState();
}

class _MainCategoryFieldsState extends State<MainCategoryFields>
    with AlertDialogMixin {
  DateTime? choosedDate;

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  @override
  void initState() {
    _checkTheCurrentTab()
        ? BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList()
        : BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
    print('Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
    super.initState();
  }

  bool _checkTheCurrentTab() => BlocProvider.of<AddExpOrIncCubit>(context)
      .expMainCats
      .any((element) => element == widget.mainCategoryName);

  @override
  void dispose() {
    amountCtrl.dispose();
    nameCtrl.dispose();
    descriptionCtrl.dispose();
    super.dispose();
  }

  _showSuccessAndNavigate(BuildContext context) async {
    showSuccessfulDialog(context, AppStrings.successfullyAdded.tr());
    await BlocProvider.of<HomeCubit>(context).getTheGeneralStatsModel();
    print('Successfully Confirmed');
    //  showSuccessfulDialogNoOptions(context, 'Successfully added');
  }

  void showDatePick(context) async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (datePicker == null) return;
    BlocProvider.of<AddExpOrIncCubit>(context).changeDate(datePicker);
  }

  Future<void> _validateFields(
      BuildContext context, TransactionModel transactionModel) async {
    final addExpIncCubit = context.read<AddExpOrIncCubit>();
    addExpIncCubit.currentAmount = transactionModel.amount;
    if (transactionModel.amount == 0) {
      errorSnackBar(context: context, message: AppStrings.kindlyPutTheAmount.tr());
    } else if (addExpIncCubit.subCatName.isEmpty) {
      errorSnackBar(
          context: context, message: AppStrings.kindlyChooseSubCategory.tr());
    } else if (transactionModel.name.trim().isEmpty) {
      errorSnackBar(context: context, message: AppStrings.kindlyWriteTheName.tr());
    } else {
      transactionModel.isExpense
          ? await addExpIncCubit.addExpense(expenseModel: transactionModel)
          : await addExpIncCubit.addIncome(incomeModel: transactionModel);
      print(
          'Choosed Date before Adding in income widget is ${transactionModel.isExpense}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isEnglish = translator.activeLanguageCode == 'en';
    return BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () =>
                  widget.addExpOrIncCubit.chooseMainCategory(widget.mainCategoryName),
              child: MainCategoryChoice(
                  mainCategoryName: widget.mainCategoryName, homeIcons: widget.icons),
            ),
            Visibility(
              visible:
                  widget.addExpOrIncCubit.currentMainCat == widget.mainCategoryName,
              replacement: const SizedBox.shrink(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  SubCategoryFields(
                      subCatsList: widget.subCategoriesList,
                      addExpOrIncCubit: widget.addExpOrIncCubit),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 65.w,
                        child: EditableInfoField(
                          textEditingController: amountCtrl,
                          hint: AppStrings.amount.tr(),
                          iconName: AppIcons.amountIcon,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      FittedBox(
                          child: Text(
                        AppStrings.egp.tr(),
                        style: textTheme.headline5!.copyWith(
                            color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(width: .4.w),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  SizedBox(
                    width: 65.w,
                    child: EditableInfoField(
                      textEditingController: nameCtrl,
                      hint: _checkTheCurrentTab()
                          ? AppStrings.expenseName.tr()
                          : AppStrings.incomeName.tr(),
                      iconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  SizedBox(
                      width: 65.w,
                      child: DateChooseContainer(
                        onTap: () async => showDatePick(context),
                        dateTime: widget.addExpOrIncCubit.chosenDate,
                      )),
                  SizedBox(height: 1.5.h),
                  SizedBox(
                    width: 65.w,
                    child: EditableInfoField(
                      textEditingController: descriptionCtrl,
                      hint: AppStrings.writeDescription.tr(),
                      iconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Column(
                    crossAxisAlignment:
                        isEnglish ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      CustomCheckBox(
                          isImportant: widget.addExpOrIncCubit.isImportant,
                          text: _checkTheCurrentTab()
                              ? AppStrings.important.tr()
                              : AppStrings.fixed.tr(),
                          onChanged: widget.addExpOrIncCubit.isImportantOrNo),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomCheckBox(
                              isImportant: widget.addExpOrIncCubit.isRepeat,
                              onChanged: (value) =>
                                  widget.addExpOrIncCubit.isRepeatOrNo(value),
                              text: AppStrings.repeat.tr()),
                          BlocListener<AddExpOrIncCubit, AddExpOrIncState>(
                            listener: (context, state) async {
                              if (state is AddExpOrIncError) {
                                errorSnackBar(
                                    context: context, message: AppStrings.tryAgain);
                              }
                              if (state is AddExpOrIncSuccess) {
                                await _showSuccessAndNavigate(context);
                              }
                            },
                            child: CustomElevatedButton(
                              onPressed: () async {
                                await _validateFields(
                                  context,
                                  TransactionModel.expense(
                                      id: GUIDGen.generate(),
                                      name: nameCtrl.text.trimLeft(),
                                      amount: amountCtrl.text.isNotEmpty
                                          ? double.parse(amountCtrl.text)
                                          : 0,
                                      description: descriptionCtrl.text,
                                      comment: amountCtrl.text,
                                      repeatType: widget.addExpOrIncCubit.choseRepeat,
                                      mainCategory:
                                          widget.addExpOrIncCubit.currentMainCat,
                                      // Todo: what is the isAddAuto for ?.
                                      isAddAuto: false,
                                      isPriority: widget.addExpOrIncCubit.isImportant,
                                      subCategory: widget.addExpOrIncCubit.subCatName,
                                      isExpense: widget.addExpOrIncCubit.isExpense =
                                          _checkTheCurrentTab() ? true : false,
                                      isProcessing: false,
                                      createdDate:
                                          context.read<AddExpOrIncCubit>().chosenDate,
                                      paymentDate: widget.addExpOrIncCubit.chosenDate),
                                );

                                print(
                                    "chooosen daaaaate is ${widget.addExpOrIncCubit.chosenDate}");
                              },
                              text: AppStrings.add.tr(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Visibility(
                        visible: widget.addExpOrIncCubit.isRepeat,
                        replacement: const SizedBox.shrink(),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70.w,
                              child: GoalsFilterWidget(
                                  icon: null,
                                  isEnglish: isEnglish,
                                  leadingIcon: !isEnglish
                                      ? AppIcons.backWordArrow
                                      : AppIcons.forwardArrow,
                                  leadingIconColor: AppColor.primaryColor,
                                  dropDownList:
                                      widget.addExpOrIncCubit.dropDownChannelItems,
                                  hint: widget.addExpOrIncCubit.choseRepeat.tr(),
                                  onChangedFunc: widget.addExpOrIncCubit.chooseRepeat),
                            ),
                            if (!isEnglish) const Spacer()
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.2.h),
                ],
              ),
            ),
            SizedBox(height: 3.5.h),
          ],
        );
      },
    );
  }
}
