/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_infor_field.dart';
import 'package:temp/presentation/widgets/editable_text.dart';

import 'choose_container.dart';
import 'main_category_choice.dart';

class AddIncOrExpWidget extends StatefulWidget {
  const AddIncOrExpWidget({Key? key}) : super(key: key);


  @override
  _AddIncOrExpWidgetState createState() => _AddIncOrExpWidgetState();
}

class _AddIncOrExpWidgetState extends State<AddIncOrExpWidget> {
  DateTime? choosedDate;
  bool isSubChoosed=false;
  bool choosed=false;
  bool isRepeat=false;
  String currentID='';
  TextEditingController amountCtrl=TextEditingController();
  TextEditingController descriptionCtrl=TextEditingController();
  List<SubCategoryExpense> list=[
    SubCategoryExpense(
      subCategoryExpenseId: 'ssfsf55',
      subCategoryExpenseName: 'Feeeee',
        mainCategoryExpenseName:'Fixed',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.star.codePoint
    ),
    SubCategoryExpense(
        subCategoryExpenseId: 'odfiefi25',
      mainCategoryExpenseName:'Fixed',
      subCategoryExpenseName: 'KIMMMNA',

      subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.star.codePoint,
    ),
    SubCategoryExpense(
        subCategoryExpenseId: 'efefgg99',
        mainCategoryExpenseName:'Fixed',
        subCategoryExpenseName: 'KIMMMNA',
        subCategoryExpenseColor: 'red',
        subCategoryExpenseIconName: 'sss',
        subCategoryExpenseIconCodePoint: Icons.star.codePoint
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
            MainCategoryChoice(mainCategoryName: 'Fixed',),
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
                          currentID=list[index].subCategoryExpenseId;

                        });
                      },
                        child: SubCategoryChoice(color: Colors.red,currentID: currentID,subCategoryExpense: list[index],));
                  }),
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

            MainCategoryChoice(mainCategoryName: 'Variable'),
          ],
    ));
  }


}



*/
