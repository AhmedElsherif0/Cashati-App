import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import '../styles/colors.dart';
import 'category_info_field.dart';
import 'common_texts/green_text.dart';
import 'editable_infor_field.dart';

class AddSubCategoryWidget extends StatefulWidget {
  const AddSubCategoryWidget({Key? key, required this.mainCategoryName})
      : super(key: key);
  final String mainCategoryName;

  @override
  State<AddSubCategoryWidget> createState() => _AddSubCategoryWidgetState();
}

class _AddSubCategoryWidgetState extends State<AddSubCategoryWidget>
    with AlertDialogMixin {
  final TextEditingController subCategoryName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    subCategoryName.dispose();
    super.dispose();
  }

  void _validation(AddSubcategoryCubit addSubcategoryCubit) {
    if (formKey.currentState!.validate()) {
      print('validated');
      addSubcategoryCubit.filterSubCategory(subCategoryName.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = translator.activeLanguageCode == 'en';
    final addSubcategoryCubit = BlocProvider.of<AddSubcategoryCubit>(context);
    return BlocListener<AddSubcategoryCubit, AddSubcategoryState>(
      listener: (context, state) {
        if (state is AddedExpSubcategorySuccessfully) {
          BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList();
        } else if (state is AddedIncSubcategorySuccessfully) {
          BlocProvider.of<AddExpOrIncCubit>(context).addMoreToIncomeList();
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 44.0, bottom: 44, left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreenText(text: AppStrings.mainCategory.tr()),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: CategoryInfoField(
                      mainCategoryName: widget.mainCategoryName.tr()),
                ),
                GreenText(text: AppStrings.subCategory.tr()),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: EditableSubCategField(subCategoryName: subCategoryName),
                ),
                GreenText(text: AppStrings.icons.tr()),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        itemCount: addSubcategoryCubit.appList.iconsOfApp.length - 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String iconNameFromList = addSubcategoryCubit
                              .appList.iconsOfApp.keys
                              .toList()[index];
                          return InkWell(
                            onTap: () {
                              addSubcategoryCubit.chooseSubCategory(addSubcategoryCubit
                                  .appList.iconsOfApp.keys
                                  .toList()[index]);
                              successSnackBar(
                                  context: context,
                                  message:
                                      "${AppStrings.confirmedSuccessfully.tr()} ");
                            },
                            child:
                                BlocBuilder<AddSubcategoryCubit, AddSubcategoryState>(
                              builder: (context, state) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 16.0),
                                  decoration: AppDecorations.subCategory(
                                      addSubcategoryCubit.currentIconName ==
                                          iconNameFromList),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      addSubcategoryCubit
                                          .appList.iconsOfApp[iconNameFromList],
                                      color: addSubcategoryCubit.currentIconName ==
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
                  alignment: isEnglish ? Alignment.centerRight : Alignment.centerLeft,
                  child: CustomElevatedButton(
                      onPressed: () async => _validation(addSubcategoryCubit),
                      text: AppStrings.save.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
