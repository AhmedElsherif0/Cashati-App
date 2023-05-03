
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/home_cubit/home_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';
import '../../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../../../business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../router/app_router_names.dart';
import '../buttons/elevated_button.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

class AddIncomeWidget extends StatefulWidget {
  const AddIncomeWidget({Key? key}) : super(key: key);

  @override
  _AddIncomeWidgetState createState() => _AddIncomeWidgetState();
}

class _AddIncomeWidgetState extends State<AddIncomeWidget> with AlertDialogMixin {

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();

    print(
        'Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
  }

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit =
    BlocProvider.of<AddExpOrIncCubit>(context);
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
    print('Built Inc');

    return ListView.builder(
        itemCount: addExpOrIncCubit.incomeMainCats.length,
        itemBuilder: (context, index) {
          return oneMainCategoryFields(
              addExpOrIncCubit,
              context,
              addExpOrIncCubit.incomeMainCats[index],
              addExpOrIncCubit.distributeIncomeSubcategories(
                  addExpOrIncCubit.incomeMainCats[index]));
        });
  }

  Column oneMainCategoryFields(
      AddExpOrIncCubit addExpOrIncCubit,
      BuildContext context,
      String mainCategoryName,
      List<SubCategory> subCategoriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 3.5.h,
        ),
        InkWell(
          onTap: () {
            addExpOrIncCubit.chooseMainCategory(mainCategoryName);
            //BlocProvider.of<AddExpOrIncCubit>(context).addMoreToList();
          },
          child: MainCategoryChoice(
            mainCategoryName: mainCategoryName,
          ),
        ),
        BlocConsumer<AddExpOrIncCubit, AddExpOrIncState>(
          listener: (context,state){
            if(state is AddExpOrIncSuccess){
              showSuccAndNavigate(context);
              BlocProvider.of<HomeCubit>(context).getTheGeneralStatsModel();

            }else if (state is AddExpOrIncError){
              errorSnackBar(context: context,message: 'Kindly Try again , and contact us !');

            }
          },
          builder: (context, state) {
            return Visibility(
              visible: addExpOrIncCubit.currentMainCat == mainCategoryName,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.5.h,
                  ),
                  subCategoriesListContainer(
                      subCategoriesList, addExpOrIncCubit),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Container(
                    width: 65.w,
                    child: EditableInfoField(
                      textEditingController: nameCtrl,
                      hint: 'Income Name',
                      iconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
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
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(width: .4.w),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Container(
                      width: 65.w,
                      child: DateChooseContainer(dateTime: addExpOrIncCubit.chosenDate)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Container(
                    width: 65.w,
                    child: EditableInfoField(
                      textEditingController: descriptionCtrl,
                      hint: 'Write Description',
                      iconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 3.h,
                        width: 4.w,
                        child: Checkbox(
                          value: addExpOrIncCubit.isRepeat,
                          onChanged: addExpOrIncCubit.isRepeatOrNo,
                          hoverColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: AppColor.white,
                          checkColor: AppColor.white,
                          fillColor: MaterialStateProperty.all(
                              AppColor.primaryColor),
                        ),
                      ),
                      SizedBox(
                        width: 2.5.w,
                      ),
                      Text(
                        'Repeat',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColor.primaryColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Visibility(
                    visible: addExpOrIncCubit.isRepeat,
                    child: Container(
                      width: 65.w,
                      child: DropDownCustomWidget(
                          dropDownList:
                          addExpOrIncCubit.dropDownChannelItems,
                          hint: addExpOrIncCubit.choseRepeat,
                          onChangedFunc: addExpOrIncCubit.chooseRepeat),
                    ),
                    replacement: SizedBox(),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  CustomElevatedButton(
                    onPressed: (){
                      print('Choosed Date before Adding in income widget is ${addExpOrIncCubit.chosenDate}');

                      addExpOrIncCubit.validateields(false,context,
                        TransactionModel.income(
                            id: GUIDGen.generate(),
                            name: nameCtrl.text,
                            amount: int.parse(amountCtrl.text),
                            comment: amountCtrl.text,
                            repeatType: addExpOrIncCubit.choseRepeat,
                            mainCategory:addExpOrIncCubit.currentMainCat ,
                            isAddAuto: false,
                            subCategory: addExpOrIncCubit.subCatName,
                            isExpense: false,
                            //isPaid: choosedDate!.day==DateTime.now()?true:false,
                            isProcessing: false,
                            createdDate: DateTime.now(),
                            paymentDate: addExpOrIncCubit.chosenDate ??DateTime.now()),
                      );


                    },
                    text: 'Add',
                  ),
                ],
              ),
              replacement: SizedBox(),
            );
          },
        )
        //const MainCategoryChoice(mainCategoryName: 'Variable'),
      ],
    );
  }

  Container subCategoriesListContainer(
      List<SubCategory> subCatsList, AddExpOrIncCubit addExpOrIncCubit) {
    return Container(
      height: 28.h,
      child: GridView.builder(
          itemCount: subCatsList.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            //addExpOrIncCubit.fitRandomColors().shuffle();
            return Visibility(
              visible: index != subCatsList.length - 1,
              child: InkWell(
                  onTap: () {

                    BlocProvider.of<AddSubcategoryCubit>(context)
                        .currentMainCategory =
                        BlocProvider.of<AddExpOrIncCubit>(context)
                            .currentMainCat;
                    //TODO assign transaction type , if it is expense or income
                    BlocProvider.of<AddSubcategoryCubit>(context)
                        .transactionType =
                    addExpOrIncCubit.isExpense ? 'Expense' : 'Income';
                    addExpOrIncCubit.chooseIncomeCategory(subCatsList[index]);
                  },
                  child: SubCategoryChoice(
                    color: addExpOrIncCubit.fitRandomColors(subCatsList)[index],
                    currentID: addExpOrIncCubit.currentID,
                    subCategory: subCatsList[index],
                  )),
              replacement: InkWell(
                  onTap: () {
                    BlocProvider.of<AddSubcategoryCubit>(context)
                        .currentMainCategory =
                        BlocProvider.of<AddExpOrIncCubit>(context)
                            .currentMainCat;

                    Navigator.pushNamed(
                        context, AppRouterNames.rAddSubCategory);
                  },
                  child: SubCategoryChoice(
                    color: AppColor.green,
                    currentID: 'feverrrr',
                    subCategory: AppConstantList().addMoreOption ,
                  )),
            );
          }),
    );
  }

  showSuccAndNavigate(BuildContext context){
    //showLoadingDialog(context);
    //Navigator.pop(context);
    showSuccessfulDialogNoOptions(
        context, 'Added Successfully', '');

    Future.delayed(
      Duration(seconds: 2),
          () {
       // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, AppRouterNames.rHomeRoute);
      },
    );
  }

}
