import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/presentation/widgets/add_subcategory_widget.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';

class AddSubCategoryScreen extends StatelessWidget {
  const AddSubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            children: [
              CustomAppBar(title: 'Add Subcategory'),
              AddSubCategoryWidget(mainCategoryName:context.read<AddSubcategoryCubit>().currentMainCategory),
            ],
          ),
        );

  }
}
