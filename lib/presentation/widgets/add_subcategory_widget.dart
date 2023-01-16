import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';

import '../styles/colors.dart';
import 'category_info_field.dart';
import 'common_texts/green_text.dart';
import 'editable_infor_field.dart';

class AddSubCategoryWidget extends StatelessWidget {
  AddSubCategoryWidget({
    Key? key,
    required this.mainCategoryName,
  }) : super(key: key);
  final String mainCategoryName;

  TextEditingController subCategoryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AddSubcategoryCubit addSubcategoryCubit =
        BlocProvider.of<AddSubcategoryCubit>(context);
    return Form(
      key: addSubcategoryCubit.formKey,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
            top: 44.0, bottom: 44, left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const GreenText(text:'Main Category'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
              child: CategoryInfoField(mainCategoryName: mainCategoryName),
            ),
            const GreenText(text: 'Sub Category'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
              child: EditableSubCategField(subCategoryName: subCategoryName),
            ),
            const GreenText(text: 'Icons'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
              child: Container(
                height: 100,
                child: ListView.builder(
                    //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1),

                    itemCount: addSubcategoryCubit.iconsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          addSubcategoryCubit.chooseSubCategory(
                              addSubcategoryCubit.iconsList[index]);
                        },
                        child: BlocBuilder<AddSubcategoryCubit,
                            AddSubcategoryState>(
                          builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                color: addSubcategoryCubit.currentIconData ==
                                        addSubcategoryCubit.iconsList[index]
                                    ? AppColor.primaryColor
                                    : AppColor.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: addSubcategoryCubit
                                                .currentIconData ==
                                            addSubcategoryCubit.iconsList[index]
                                        ? AppColor.white
                                        : AppColor.primaryColor),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  addSubcategoryCubit.iconsList[index],
                                  color: addSubcategoryCubit.currentIconData ==
                                          addSubcategoryCubit.iconsList[index]
                                      ? AppColor.white
                                      : AppColor.primaryColor,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
            ),
            CustomElevatedButton(
                onPressed: () =>
                    addSubcategoryCubit.addSubCategory(subCategoryName.text),
                text: 'Save'),
          ],
        ),
      )),
    );
  }
}
