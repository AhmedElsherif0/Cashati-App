import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/custom_check_box.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/sub_category_fields.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_strings.dart';
import '../../../data/local/hive/id_generator.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../../data/models/transactions/transaction_model.dart';
import '../../router/app_router_names.dart';
import '../../styles/colors.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';
import '../buttons/elevated_button.dart';
import '../drop_down_custom.dart';
import '../editable_text.dart';

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
    // TODO: implement initState
    super.initState();
    _checkTheCurrentTab()
        ? BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList()
        : BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
    print('Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    nameCtrl.dispose();
    descriptionCtrl.dispose();
    super.dispose();
  }

  bool _checkTheCurrentTab() => widget.addExpOrIncCubit.expMainCats
      .any((element) => element == widget.mainCategoryName);

  showSuccessAndNavigate(BuildContext context) {
    showSuccessfulDialog(context, AppStrings.successfullyAdded.tr());
    print('Successfully Confirmed');

    //  showSuccessfulDialogNoOptions(context, 'Successfully added');
  }

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

  AddExpOrIncCubit getAddExpOrIncCubit() => BlocProvider.of<AddExpOrIncCubit>(context);

  @override
  Widget build(BuildContext context) {
    final isEnglish = translator.activeLanguageCode == 'en';
    return BlocConsumer<AddExpOrIncCubit, AddExpOrIncState>(
      listener: (context, state) {
        if (state is AddExpOrIncError) {
          errorSnackBar(context: context, message: AppStrings.tryAgain);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                widget.addExpOrIncCubit.chooseMainCategory(widget.mainCategoryName);
                //BlocProvider.of<AddExpOrIncCubit>(context).addMoreToList();
              },
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
                        style: Theme.of(context).textTheme.headline5!.copyWith(
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
                        onTap: () async => showDatePick(),
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
                      crossAxisAlignment: isEnglish
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
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
                            CustomElevatedButton(
                              onPressed: () {
                                widget.addExpOrIncCubit.validateields(
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
                                      isAddAuto: false,
                                      isPriority: widget.addExpOrIncCubit.isImportant,
                                      subCategory: widget.addExpOrIncCubit.subCatName,
                                      isExpense: widget.addExpOrIncCubit.isExpense =
                                          _checkTheCurrentTab()
                                              ? widget.addExpOrIncCubit.isExpense =
                                                  true
                                              : widget.addExpOrIncCubit.isExpense =
                                                  false,
                                      isProcessing: false,
                                      createdDate:
                                          getAddExpOrIncCubit().chosenDate as DateTime,
                                      paymentDate: widget.addExpOrIncCubit.chosenDate
                                          as DateTime),
                                );
                                if(state is AddExpOrIncSuccess){
                                  showSuccessAndNavigate(context);
                                  BlocProvider.of<HomeCubit>(context).getTheGeneralStatsModel();
                                }
                                print(
                                    "chooosen daaaaate is ${widget.addExpOrIncCubit.chosenDate}");
                              },
                              text: AppStrings.add.tr(),
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
                                child: DropDownCustomWidget(
                                    icon: isEnglish ? AppIcons.forwardArrow : '',
                                    isEnglish: isEnglish,
                                    leadingIcon:
                                        !isEnglish ? AppIcons.backWordArrow : '',
                                    leadingIconColor: AppColor.primaryColor,
                                    dropDownList:
                                        widget.addExpOrIncCubit.dropDownChannelItems,
                                    hint: widget.addExpOrIncCubit.choseRepeat.tr(),
                                    onChangedFunc:
                                        widget.addExpOrIncCubit.chooseRepeat),
                              ),
                              if (!isEnglish) const Spacer()
                            ],
                          ),
                        ),
                      ]),
                  SizedBox(height: 1.2.h),
                ],
              ),
            ),
            SizedBox(height: 3.5.h),
            //const MainCategoryChoice(mainCategoryName: 'Variable'),
          ],
        );
      },
    );
  }
}
