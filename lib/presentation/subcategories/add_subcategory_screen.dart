import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_presentation_strings.dart';
import 'package:temp/presentation/widgets/add_subcategory_widget.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';

class AddSubCategoryScreen extends StatelessWidget {
  const AddSubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpOrIncCubit>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: AppPresentationStrings.addSubcategoryEng),
            BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
              builder: (context, state) {
                return AddSubCategoryWidget(
                  mainCategoryName: cubit.currentMainCat,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
