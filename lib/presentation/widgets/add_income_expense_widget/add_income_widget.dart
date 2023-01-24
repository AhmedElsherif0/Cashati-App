import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
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

class _AddIncomeWidgetState extends State<AddIncomeWidget> {
  DateTime? choosedDate;

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
          height: 35,
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
        BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
          builder: (context, state) {
            return Visibility(
              visible: addExpOrIncCubit.currentMainCat == mainCategoryName,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  subCategoriesListContainer(
                      subCategoriesList, addExpOrIncCubit),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 270,
                    child: EditableInfoField(
                      textEditingController: nameCtrl,
                      hint: 'Income Name',
                      IconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 270,
                        child: EditableInfoField(
                          textEditingController: amountCtrl,
                          hint: 'Amount',
                          IconName: AppIcons.amountIcon,
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
                      SizedBox(width: 4),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 270,
                      child: DateChooseContainer(dateTime: addExpOrIncCubit.chosenDate)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 270,
                    child: EditableInfoField(
                      textEditingController: descriptionCtrl,
                      hint: 'Write Description',
                      IconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    child: Row(
                      children: [
                        BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 30,
                              width: 40,
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
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: addExpOrIncCubit.isRepeat,
                        child: Container(
                          width: 270,
                          child: DropDownCustomWidget(
                              dropDownList:
                              addExpOrIncCubit.dropDownChannelItems,
                              hint: addExpOrIncCubit.choseRepeat,
                              onChangedFunc: addExpOrIncCubit.chooseRepeat),
                        ),
                        replacement: SizedBox(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(
                    onPressed: (){
                      addExpOrIncCubit.validateIncomeFields(context,amountCtrl.text,
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
                            paymentDate: choosedDate ?? DateTime.now()),
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
      height: 250,
      child: GridView.builder(
          itemCount: subCatsList.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            //addExpOrIncCubit.fitRandomColors().shuffle();
            return BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(

              builder: (context, s) {
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
              },
            );
          }),
    );
  }
}
