import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';

import '../router/app_router_names.dart';
import '../styles/colors.dart';
import 'category_info_field.dart';
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
    return BlocListener<AddSubcategoryCubit, AddSubcategoryState>(
      listener: (context, state) {
       if(state is AddedExpSubcategorySuccessfully){
         addSubcategoryCubit.goBackWithNewData(context,isExpSub:true);
       }
       else if(state is AddedIncSubcategorySuccessfully){
         addSubcategoryCubit.goBackWithNewData(context,isExpSub:false);


       }
      },
      child: Form(
        key: addSubcategoryCubit.formKey,
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 44.0, bottom: 44, left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Category',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                    child: CategoryInfoField(mainCategoryName: mainCategoryName),
                  ),
                  Text(
                    'Sub Category',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                    child: EditableSubCategField(subCategoryName: subCategoryName),
                  ),
                  Text(
                    'Icons',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          addSubcategoryCubit.addSubCategory(subCategoryName.text,context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Save',
                          ),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
