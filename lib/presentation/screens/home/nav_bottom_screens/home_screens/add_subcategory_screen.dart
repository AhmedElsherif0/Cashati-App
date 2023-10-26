import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/views/custom_app_bar.dart';
import 'package:temp/presentation/widgets/add_subcategory_widget.dart';

class AddSubCategoryScreen extends StatelessWidget {
  const AddSubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: AppStrings.addSubcategory.tr()),
            BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
              builder: (context, state) {
                return AddSubCategoryWidget(
                  mainCategoryName: context.read<AddExpOrIncCubit>().currentMainCat,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
