import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';

import '../../../constants/app_icons.dart';
import '../../styles/colors.dart';

class MainCategoryChoice extends StatefulWidget {
  const MainCategoryChoice(
      {Key? key, required this.mainCategoryName, required this.homeIcons})
      : super(key: key);
  final String mainCategoryName;
  final String homeIcons;

  @override
  _MainCategoryChoiceState createState() => _MainCategoryChoiceState();
}

class _MainCategoryChoiceState extends State<MainCategoryChoice> {
  bool isChoosed = false;

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit = BlocProvider.of<AddExpOrIncCubit>(context);
    return InkWell(
      onTap: () {
        if (addExpOrIncCubit.currentMainCat == widget.mainCategoryName) {
          addExpOrIncCubit.chooseMainCategory('');
        } else {
          addExpOrIncCubit.chooseMainCategory(widget.mainCategoryName);
        }
      },
      child: BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
        builder: (context, state) {
          return Visibility(
            visible: addExpOrIncCubit.currentMainCat != widget.mainCategoryName,
            replacement: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 600),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.primaryColor),
              child: ListTile(
                leading: SvgPicture.asset(widget.homeIcons, color: AppColor.white),
                title: Text(widget.mainCategoryName,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                trailing: SvgPicture.asset(AppIcons.downArrow, color: AppColor.white),
              ),
            ),
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 600),
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColor.primaryColor, width: 1),
                color: AppColor.white,
              ),
              child: ListTile(
                leading:
                    SvgPicture.asset(widget.homeIcons, color: AppColor.primaryColor),
                title: Text(
                  widget.mainCategoryName,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
