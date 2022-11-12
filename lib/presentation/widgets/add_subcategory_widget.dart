import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'category_info_field.dart';
import 'editable_infor_field.dart';

class AddSubCategoryWidget extends StatelessWidget {
   AddSubCategoryWidget({
    Key? key,
    required this.mainCategoryName,
  }) : super(key: key);
  final String mainCategoryName;

   final GlobalKey<FormState> formKey=GlobalKey<FormState>();

   TextEditingController subCategoryTry=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Form(
      key:formKey ,
      child: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(top: 44.0,bottom: 44,left: 24.0,right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Main Category',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 32.0),
              child: CategoryInfoField(mainCategoryName: mainCategoryName),
            ),
            Text('Sub Category',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 32.0),
              child: EditableSubCategField(subCategoryName:subCategoryTry),

            ),
            Text('Icons',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 32.0),
              child: Container(
                height:100 ,

                child: ListView.builder(
                  //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1),

                    itemCount: 30,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.primaryColor),
                        ),
                        child: Padding(padding: EdgeInsets.all(8),
                          child: Icon(Icons.menu,color: AppColor.primaryColor,),
                        ),
                      );
                    }),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      print('validated');

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${subCategoryTry.text}')));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Save',),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
