
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/expenses/expense_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_infor_field.dart';
import 'package:temp/presentation/widgets/editable_text.dart';

import '../../../data/local/hive/hive_database.dart';
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
  bool isSubChoosed=false;
  bool isRepeat=false;
  String currentID='';
  String? subCatName;
  TextEditingController amountCtrl=TextEditingController();
  TextEditingController descriptionCtrl=TextEditingController();
  TextEditingController nameCtrl=TextEditingController();
  List<SubCategoryExpense> list=[
    SubCategoryExpense.copyWith(
      id: 'ssfsf55',
      subCategoryExpenseName: 'Transportation',
        mainCategoryExpenseName:'Home',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint
    ),
    SubCategoryExpense.copyWith(
        id: 'odfiefi25',
      mainCategoryExpenseName:'Home',
      subCategoryExpenseName: 'Food',

      subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.star.codePoint,
    ),
    SubCategoryExpense.copyWith(
        id: 'efefgg99',
        mainCategoryExpenseName:'Home',
        subCategoryExpenseName: 'Random',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint
    ),
    SubCategoryExpense.copyWith(
        id: 'efefggs99',
        mainCategoryExpenseName:'Home',
        subCategoryExpenseName: 'Try1',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint
    ),
    SubCategoryExpense.copyWith(
        id: 'efefefefggs99',
        mainCategoryExpenseName:'Home',
        subCategoryExpenseName: 'Try2',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint
    ),
    SubCategoryExpense.copyWith(
        id: 'efefef4rggs99',
        mainCategoryExpenseName:'Home',
        subCategoryExpenseName: 'Try3',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint
    ),
    SubCategoryExpense.copyWith(
        id: 'rf33f',
        mainCategoryExpenseName:'Home',
        subCategoryExpenseName: 'Try4',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint
    ),
    SubCategoryExpense.copyWith(
        id: 'rf33wwwwf',
        mainCategoryExpenseName:'Home',
        subCategoryExpenseName: 'Try5',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint
    ),
  ];
  String dropDownValue='Choose Repeat';
  List<DropdownMenuItem<String>> dropDownChannelItems=[
    DropdownMenuItem(child: Text('Daily'),value: 'Daily',),
    DropdownMenuItem(child: Text('Weekly'),value: 'Weekly'),
    DropdownMenuItem(child: Text('Monthly'),value: 'Monthly'),
    DropdownMenuItem(child: Text('No Repeat'),value: 'No Repeat'),

  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35,),
            MainCategoryChoice(mainCategoryName: 'Home',),
            Visibility(
              visible: isSubChoosed,
                child: SizedBox(height: 45,),
            replacement:SizedBox(height: 35,),
            ),
            Container(
              height: 250,
              child: GridView.builder(
                itemCount: list.length,

                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20

                  ),

                  itemBuilder: (context,index){
                  bool isChoosed=false;
                    return InkWell(
                      onTap: (){
                        setState(() {
                          //currentID=list.where((element) => element.subCategoryExpenseId==currentID).single.subCategoryExpenseId;
                          currentID=list[index].id;
                          subCatName=list[index].subCategoryExpenseName;

                        });
                      },
                        child: SubCategoryChoice(color: Colors.red,currentID: currentID,
                          subCatIconCode:  list[index].subCategoryExpenseIconCodePoint,
                          subCatID:   list[index].id,
                          subCatName:   list[index].subCategoryExpenseIconName,));
                  }),
            ),
            SizedBox(height: 10,),
            Container(
              width: 270,
              child: EditableInfoField(textEditingController: nameCtrl, hint: 'Expense Name',
                IconName: AppIcons.descriptionIcon,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 270,
                  child: EditableInfoField(textEditingController: amountCtrl, hint: 'Amount',
                      IconName: AppIcons.amountIcon,
                  keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 40,),
                FittedBox(child: Text('EGP',style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.bold),)),
              ],
            ),


            SizedBox(height: 10,),
            Container(
                width: 270,
                child: DateChooseContainer(dateTime: choosedDate)),

            SizedBox(height: 10,),
            Container(
              width: 270,
              child: EditableInfoField(textEditingController: descriptionCtrl, hint: 'Write Description',
                IconName: AppIcons.descriptionIcon,
                keyboardType: TextInputType.text,
              ),
            ),

            SizedBox(height: 10,),
            Container(
              width: 250,
              child: Row(
                children: [
                  SizedBox(
                    height:30,
                    width: 40,
                    child: Checkbox(

                      value: isRepeat,
                        onChanged: (val){
                      setState(() {
                         isRepeat=val!;
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
                  SizedBox(width: 10,),
                  Text('Repeat',style: Theme.of(context).textTheme.bodyLarge! .copyWith(color: AppColor.primaryColor),)
                ],
              ),
            ),
            SizedBox(height: 10,),

            Visibility(
              visible: isRepeat,
              child: Container(
                width: 270,
                child: DropDownCustomWidget(
                    dropDownList: dropDownChannelItems,
                    hint: dropDownValue, onChangedFunc: (value){
                      setState(() {
                        dropDownValue=value;
                      });
                },

                ),
              ),
              replacement: SizedBox(),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              HiveHelper().getBox(boxName: AppBoxes.expenseModel).add(ExpenseModel.copyWith(id: GUIDGen.generate(),
                  name: nameCtrl.text,
                  amount: int.parse(amountCtrl.text)??500,
                  comment: amountCtrl.text,
                  repeatType: dropDownValue,
                  mainCategory: 'Home',
                  isAddAuto: false,
                  isPriority: false,
                  subCategory: subCatName??'SubCategoryDefault',
                  isReceiveNotification: true,
                  isPaid: choosedDate!.day==DateTime.now()?true:false,
                  createdDate: DateTime.now(),
                  paymentDate: choosedDate??DateTime.now()));
            }, child: Text('Add')),

            MainCategoryChoice(mainCategoryName: 'Variable'),
          ],
    ));
  }


}




