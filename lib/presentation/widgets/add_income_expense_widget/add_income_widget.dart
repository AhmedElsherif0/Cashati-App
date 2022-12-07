import 'dart:math';

import 'package:flutter/material.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/subcategories_models/income_subcaegory_model.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import '../../../data/local/hive/hive_database.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

class AddIncomeWidget extends StatefulWidget {
  const AddIncomeWidget({Key? key}) : super(key: key);

  @override
  _AddIncomeWidgetState createState() => _AddIncomeWidgetState();
}

class _AddIncomeWidgetState extends State<AddIncomeWidget> {
  DateTime? choosedDate;
  bool isSubChoosed = false;
  bool isRepeat = false;
  String currentID = '';
  String? subCatName;

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  List<SubCategoryIncome> list = [
    SubCategoryIncome.copyWith(
        id: 'ssfsf55',
        subCategoryIncomeName: 'Full Time',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
    SubCategoryIncome.copyWith(
        id: 'ssfsdggef55',
        subCategoryIncomeName: 'Part Time',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
    SubCategoryIncome.copyWith(
        id: 'knfwoglf55',
        subCategoryIncomeName: 'Freelance Designing',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
    SubCategoryIncome.copyWith(
        id: 'sdwfwgr533',
        subCategoryIncomeName: 'Freelance Marketing',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
    SubCategoryIncome.copyWith(
        id: 'sdwfw21gr533',
        subCategoryIncomeName: 'Weekly Work',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
    SubCategoryIncome.copyWith(
        id: 's1333535dwfw21gr533',
        subCategoryIncomeName: 'Friday Programming',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
    SubCategoryIncome.copyWith(
        id: 'sokogkenemwk3356',
        subCategoryIncomeName: 'Interviews',
        mainCategoryIncomeName: 'Fixed',
        subCategoryIncomeColor: 'red',
        subCategoryIncomeIconName: 'sss',
        subCategoryIncomeCodePoint: Icons.ten_k.codePoint),
  ];
  String dropDownValue = 'Choose Repeat';
  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(
      child: Text('Daily'),
      value: 'Daily',
    ),
    DropdownMenuItem(child: Text('Weekly'), value: 'Weekly'),
    DropdownMenuItem(child: Text('Monthly'), value: 'Monthly'),
    DropdownMenuItem(child: Text('No Repeat'), value: 'No Repeat'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
        ),
        MainCategoryChoice(
          mainCategoryName: 'Fixed',
        ),
        Visibility(
          visible: isSubChoosed,
          child: SizedBox(
            height: 45,
          ),
          replacement: SizedBox(
            height: 35,
          ),
        ),
        Container(
          height: 250,
          child: GridView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
              itemBuilder: (context, index) {
                bool isChoosed = false;
                return InkWell(
                  onTap: () {
                    setState(() {
                      //currentID=list.where((element) => element.subCategoryExpenseId==currentID).single.subCategoryExpenseId;
                      currentID = list[index].id;
                      subCatName = list[index].subCategoryIncomeName;
                    });
                  },
                  child: SubCategoryChoice(
                    color: Colors.red,
                    currentID: currentID,
                    subCatIconCode: list[index].subCategoryIncomeCodePoint,
                    subCatID: list[index].id,
                    subCatName: list[index].subCategoryIncomeName,
                  ),
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
            SizedBox(
              width: 40,
            ),
            FittedBox(
                child: Text(
              'EGP',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppColor.primaryColor, fontWeight: FontWeight.bold),
            )),
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
              SizedBox(
                height: 30,
                width: 40,
                child: Checkbox(
                  value: isRepeat,
                  onChanged: (val) {
                    setState(() {
                      isRepeat = val!;
                    });
                  },
                  hoverColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeColor: AppColor.white,
                  checkColor: AppColor.white,
                  fillColor: MaterialStateProperty.all(AppColor.primaryColor),
                ),
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
        Visibility(
          visible: isRepeat,
          child: Container(
            width: 270,
            child: DropDownCustomWidget(
              dropDownList: dropDownChannelItems,
              hint: dropDownValue,
              onChangedFunc: (value) {
                setState(() {
                  dropDownValue = value;
                });
              },
            ),
          ),
          replacement: SizedBox(),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              HiveHelper().getBoxName(boxName: AppBoxes.incomeModel).add(
                  TransactionModel.income(
                      id: GUIDGen.generate(),
                      name: nameCtrl.text,
                      amount: int.parse(amountCtrl.text) ?? 400,
                      comment: amountCtrl.text,
                      repeatType: dropDownValue,
                      mainCategory: 'Fixed',
                      isAddAuto: false,
                      isProcessing: false,
                      subCategory: subCatName ?? 'SubCategoryDefault',
                      isReceiveNotification: true,
                      createdDate: DateTime.now(),
                      paymentDate: choosedDate ?? DateTime.now()));
            },
            child: Text('Add')),
        MainCategoryChoice(mainCategoryName: 'Variable'),
      ],
    ));
  }
}
