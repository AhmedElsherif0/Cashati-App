import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({Key? key}) : super(key: key);

  @override
  _AddExpenseWidgetState createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  DateTime? choosedDate;

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  // List<SubCategoryExpense> list = [
  //   SubCategoryExpense.copyWith(
  //       id: 'ssfsf55',
  //       subCategoryExpenseName: 'Transportation',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint),
  //   SubCategoryExpense.copyWith(
  //     id: 'odfiefi25',
  //     mainCategoryExpenseName: 'Home',
  //     subCategoryExpenseName: 'Food',
  //     subCategoryExpenseColor: 'red',
  //     subCategoryExpenseIconName: 'sss',
  //     subCategoryExpenseIconCodePoint: Icons.star.codePoint,
  //   ),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefgg99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Random',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefggs99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try1',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefefefggs99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try2',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'efefef4rggs99',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try3',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'rf33f',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try4',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  //   SubCategoryExpense.copyWith(
  //       id: 'rf33wwwwf',
  //       mainCategoryExpenseName: 'Home',
  //       subCategoryExpenseName: 'Try5',
  //       subCategoryExpenseColor: 'red',
  //       subCategoryExpenseIconName: 'sss',
  //       subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToList();

    print(
        'Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
  }

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit =
        BlocProvider.of<AddExpOrIncCubit>(context);
    BlocProvider.of<AddExpOrIncCubit>(context).fitRandomColors();

    return ListView.builder(
        itemCount: addExpOrIncCubit.expMainCats.length,
        itemBuilder: (context,index){
          return oneMainCategoryFields(addExpOrIncCubit,context,addExpOrIncCubit.expMainCats[index]);
        });
  }

  Column oneMainCategoryFields(AddExpOrIncCubit addExpOrIncCubit, BuildContext context,String mainCategoryName) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 35,
      ),
      InkWell(
        onTap: (){
          addExpOrIncCubit.chooseMainCategory(mainCategoryName);
        },
        child: MainCategoryChoice(
          mainCategoryName: mainCategoryName,
        ),
      ),
      BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
  builder: (context, state) {
    return Visibility(
        visible: addExpOrIncCubit.currentMainCat==mainCategoryName,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
            ),
            Container(
              height: 250,
              child: GridView.builder(
                  itemCount: addExpOrIncCubit.dataList.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    print('Rebuild');
                    //addExpOrIncCubit.fitRandomColors().shuffle();

                    bool isChoosed = false;
                    return BlocConsumer<AddExpOrIncCubit, AddExpOrIncState>(
                      listener: (context, state) {
                        // if(state==AddExpOrIncInitial){
                        //   addExpOrIncCubit.addMoreToList();
                        // }
                      },
                      builder: (context, s) {
                        return Visibility(
                          visible: index != addExpOrIncCubit.dataList.length - 1,
                          child: InkWell(
                              onTap: () {
                                // setState(() {
                                //   //currentID=list.where((element) => element.subCategoryExpenseId==currentID).single.subCategoryExpenseId;
                                //   currentID = list[index].id;
                                //   subCatName = list[index].subCategoryExpenseName;
                                // });
                                addExpOrIncCubit.chooseCategory(index);
                              },
                              child: SubCategoryChoice(
                                color: addExpOrIncCubit.lastColorList[index],
                                currentID: addExpOrIncCubit.currentID,
                                subCatIconCode: addExpOrIncCubit.dataList[index]
                                    .subCategoryExpenseIconCodePoint,
                                subCatID: addExpOrIncCubit.dataList[index].id,
                                subCatName: addExpOrIncCubit
                                    .dataList[index].subCategoryExpenseName,
                              )),
                          replacement: InkWell(
                              onTap: () {},
                              child: SubCategoryChoice(
                                color: AppColor.green,
                                currentID: 'feverrrr',
                                subCatIconCode: Icons.add.codePoint,
                                subCatID: 'jjjhj',
                                subCatName: 'Add More',
                              )),
                        );
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 270,
              child: EditableInfoField(
                textEditingController: nameCtrl,
                hint: 'Expense Name',
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
                          color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 270, child: DateChooseContainer(dateTime: choosedDate)),
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
                          fillColor:
                          MaterialStateProperty.all(AppColor.primaryColor),
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

                        dropDownList: addExpOrIncCubit.dropDownChannelItems,
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
            ElevatedButton(
              onPressed: () {
                addExpOrIncCubit.addExpense(
                    expenseModel: TransactionModel.expense(
                        id: GUIDGen.generate(),
                        name: nameCtrl.text,
                        amount: int.parse(amountCtrl.text),
                        comment: amountCtrl.text,
                        repeatType: addExpOrIncCubit.choseRepeat,
                        mainCategory: 'Home',
                        isAddAuto: false,
                        isPriority: false,
                        subCategory:
                        addExpOrIncCubit.subCatName ?? 'SubCategoryDefault',
                        isReceiveNotification: true,
                        //isPaid: choosedDate!.day==DateTime.now()?true:false,
                        isProcessing: false,
                        createdDate: DateTime.now(),
                        paymentDate: choosedDate ?? DateTime.now()),
                    choseRepeat: addExpOrIncCubit.choseRepeat);
              },
              child: const Text('Add'),
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
}
