import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/constants/app_presentation_strings.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';

import '../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../router/app_router_names.dart';
import '../styles/colors.dart';
import 'category_info_field.dart';
import 'common_texts/green_text.dart';
import 'editable_infor_field.dart';

class AddSubCategoryWidget extends StatefulWidget {
  const AddSubCategoryWidget({
    Key? key,
    required this.mainCategoryName,
  }) : super(key: key);
  final String mainCategoryName;

  @override
  State<AddSubCategoryWidget> createState() => _AddSubCategoryWidgetState();
}

class _AddSubCategoryWidgetState extends State<AddSubCategoryWidget> {
  final TextEditingController subCategoryName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    subCategoryName.dispose();
    super.dispose();
  }

  void validation(AddSubcategoryCubit addSubcategoryCubit) {
    if (formKey.currentState!.validate()) {
      print('validated');
      addSubcategoryCubit.filterSubCategory(subCategoryName.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Added Successfully')));
      Navigator.pushReplacementNamed(
          context, AppRouterNames.rAddExpenseOrIncomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    AddSubcategoryCubit addSubcategoryCubit =
        BlocProvider.of<AddSubcategoryCubit>(context);
    return BlocListener<AddSubcategoryCubit, AddSubcategoryState>(
      listener: (context, state) {
        if (state is AddedExpSubcategorySuccessfully) {
          addSubcategoryCubit.goBackWithNewData(context, isExpSub: true);
        } else if (state is AddedIncSubcategorySuccessfully) {
          addSubcategoryCubit.goBackWithNewData(context, isExpSub: false);
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 44.0, bottom: 44, left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GreenText(text: AppPresentationStrings.mainCategoryEng),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: CategoryInfoField(
                      mainCategoryName: widget.mainCategoryName),
                ),
                const GreenText(text:AppPresentationStrings.subSpaceCategoryEng),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child:
                      EditableSubCategField(subCategoryName: subCategoryName),
                ),
                const GreenText(text: AppPresentationStrings.iconsEng),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1),

                        itemCount:
                            addSubcategoryCubit.appList.iconsOfApp.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String iconNameFromList=addSubcategoryCubit.appList.iconsOfApp.keys.toList()[index];
                          return InkWell(
                            onTap: () {
                              addSubcategoryCubit.chooseSubCategory(
                                  addSubcategoryCubit.appList.iconsOfApp.keys
                                      .toList()[index]);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "${AppPresentationStrings.chosenIconNameEng} ${iconNameFromList}, ${AppPresentationStrings.andCurrentIconNameIsEng} ${addSubcategoryCubit.currentIconName}")));
                            },
                            child: BlocBuilder<AddSubcategoryCubit,
                                AddSubcategoryState>(
                              builder: (context, state) {
                                return Container(
                                  margin: EdgeInsets.only(right: 20.0),
                                  decoration: BoxDecoration(
                                    color:
                                        addSubcategoryCubit.currentIconName ==
                                                iconNameFromList
                                            ? AppColor.primaryColor
                                            : AppColor.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: addSubcategoryCubit
                                                    .currentIconName ==
                                            iconNameFromList
                                            ? AppColor.white
                                            : AppColor.primaryColor),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      addSubcategoryCubit.appList.iconsOfApp[iconNameFromList],
                                      color:
                                      addSubcategoryCubit
                                          .currentIconName ==
                                          iconNameFromList
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
                  child: CustomElevatedButton(
                      onPressed: () async => validation(addSubcategoryCubit),
                      text: AppPresentationStrings.saveEng),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
