import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/data/repository/helper_class.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../constants/app_icons.dart';
import '../../styles/colors.dart';
import '../../widgets/add_income_expense_widget/choose_container.dart';
import '../../widgets/editable_text.dart';

class PartTimeDetails extends StatefulWidget {
  const PartTimeDetails({Key? key, required this.transactionModel}) : super(key: key);
  final TransactionModel transactionModel;

  @override
  State<PartTimeDetails> createState() => _PartTimeDetailsState();
}

class _PartTimeDetailsState extends State<PartTimeDetails> with HelperClass {
  final TextEditingController mainCategoryController = TextEditingController();
  final TextEditingController calenderController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    subCategoryController.dispose();
    descriptionController.dispose();
    calenderController.dispose();
    // TODO: implement dispose
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

  @override
  Widget build(BuildContext context) {
    final addTransactionCubit = BlocProvider.of<AddExpOrIncCubit>(context);
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.sp),
                const CustomAppBar(
                    title: 'Food Expense Details', isEndIconVisible: false),
                SizedBox(height: 40.sp),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          SizedBox(
                              width: 90.w,
                              child: DateChooseContainer(
                                onTap: () async => showDatePick(),
                                dateTime: addTransactionCubit.chosenDate,
                              )),
                          SizedBox(height: 15.sp),
                          EditableInfoField(
                            textEditingController: mainCategoryController,
                            hint: widget.transactionModel.mainCategory,
                            iconName: AppIcons.categoryIcon,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 15.sp),
                          EditableInfoField(
                            textEditingController: subCategoryController,
                            hint: widget.transactionModel.subCategory,
                            iconName: AppIcons.categories,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 15.sp),
                          EditableInfoField(
                            textEditingController: amountController,
                            hint: '${widget.transactionModel.amount}LE',
                            iconName: AppIcons.amountIcon,
                            keyboardType: TextInputType.text,
                            trailing: IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                color: AppColor.primaryColor,
                                onPressed: () {}),
                          ),
                          SizedBox(height: 15.sp),
                          EditableInfoField(
                            textEditingController: dateController,
                            hint: widget.transactionModel.repeatType,
                            iconName: AppIcons.change,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 15.sp),
                          EditableInfoField(
                            textEditingController: descriptionController,
                            header: 'Description',
                            hint: widget.transactionModel.description == ''
                                ? 'There are many variations of... There are many variations of...'
                                : widget.transactionModel.description,
                            iconName: '',
                            keyboardType: TextInputType.multiline,
                          ),
                          SizedBox(height: 30.sp),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 16.sp,
                              backgroundColor: AppColor.primaryColor,
                              child: SvgPicture.asset(
                                  AppIcons.delete, color: AppColor.white),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
