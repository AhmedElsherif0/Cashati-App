import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
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
    showSuccessfulDialogNoOptions(context, 'Added Successfully', '');
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute));
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
    return BlocConsumer<AddExpOrIncCubit, AddExpOrIncState>(
      listener: (context, state) {
        if (state is AddExpOrIncSuccess) {
          showSuccessAndNavigate(context);
          BlocProvider.of<HomeCubit>(context).getTheGeneralStatsModel();
        } else if (state is AddExpOrIncError) {
          errorSnackBar(
              context: context, message: 'Kindly Try again , and contact us !');
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
                  SizedBox(height: 4.5.h),
                  SubCategoryFields(
                      subCatsList: widget.subCategoriesList,
                      addExpOrIncCubit: widget.addExpOrIncCubit),
                  SizedBox(height: 1.2.h),
                  SizedBox(
                    width: 65.w,
                    child: EditableInfoField(
                      textEditingController: nameCtrl,
                      hint: _checkTheCurrentTab() ? 'Expense Name' : 'Income Name',
                      iconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 65.w,
                        child: EditableInfoField(
                          textEditingController: amountCtrl,
                          hint: 'Amount',
                          iconName: AppIcons.amountIcon,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      FittedBox(
                          child: Text(
                        'EGP',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(width: .4.w),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
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
                      hint: 'Write Description',
                      iconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  CustomCheckBox(
                      isImportant: widget.addExpOrIncCubit.isImportant,
                      text: _checkTheCurrentTab() ? 'Important' : 'Fixed',
                      onChanged: widget.addExpOrIncCubit.isImportantOrNo),
                  SizedBox(height: 1.5.h),
                  CustomCheckBox(
                      isImportant: widget.addExpOrIncCubit.isRepeat,
                      onChanged: widget.addExpOrIncCubit.isRepeatOrNo,
                      text: AppStrings.repeat),
                  SizedBox(height: 1.2.h),
                  Visibility(
                    visible: widget.addExpOrIncCubit.isRepeat,
                    replacement: const SizedBox.shrink(),
                    child: SizedBox(
                      width: 65.w,
                      child: DropDownCustomWidget(
                          leadingIcon: '',
                          dropDownList: widget.addExpOrIncCubit.dropDownChannelItems,
                          hint: widget.addExpOrIncCubit.choseRepeat,
                          onChangedFunc: widget.addExpOrIncCubit.chooseRepeat),
                    ),
                  ),
                  SizedBox(height: 1.2.h),
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
                            mainCategory: widget.addExpOrIncCubit.currentMainCat,
                            isAddAuto: false,
                            isPriority: widget.addExpOrIncCubit.isImportant,
                            subCategory: widget.addExpOrIncCubit.subCatName,
                            isExpense: widget.addExpOrIncCubit.isExpense =
                                _checkTheCurrentTab()
                                    ? widget.addExpOrIncCubit.isExpense = true
                                    : widget.addExpOrIncCubit.isExpense = false,
                            //isPaid: choosedDate!.day==DateTime.now()?true:false,
                            isProcessing: false,
                            createdDate: getAddExpOrIncCubit().chosenDate as DateTime,
                            paymentDate:
                                widget.addExpOrIncCubit.chosenDate as DateTime),
                      );
                      print(
                          "chooosen daaaaate is ${widget.addExpOrIncCubit.chosenDate}");
                    },
                    text: 'Add',
                  ),
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
