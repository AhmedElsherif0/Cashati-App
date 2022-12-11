import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';

import '../../../constants/app_icons.dart';
import '../../styles/colors.dart';

class MainCategoryChoice extends StatefulWidget {
  const MainCategoryChoice({Key? key,required this.mainCategoryName}) : super(key: key);
  final String mainCategoryName;

  @override
  _MainCategoryChoiceState createState() => _MainCategoryChoiceState();
}

class _MainCategoryChoiceState extends State<MainCategoryChoice> {
  bool isChoosed=false;

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit=BlocProvider.of<AddExpOrIncCubit>(context);
    return InkWell(
      onTap: (){
        // setState(() {
        //   isChoosed=!isChoosed;
        // });
        // print('isChoosed ${isChoosed}');
        if(addExpOrIncCubit.currentMainCat==widget.mainCategoryName){
          addExpOrIncCubit.chooseMainCategory('');
        }else{
          addExpOrIncCubit.chooseMainCategory(widget.mainCategoryName);
        }
      },
      child: BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
  builder: (context, state) {
    return Visibility(
        visible:addExpOrIncCubit.currentMainCat!=widget.mainCategoryName,
        child: AnimatedContainer(

          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.primaryColor,width: 1),
            color: AppColor.white,
          ),
          duration: Duration(milliseconds:1),
          child: ListTile(
            leading:  SvgPicture.asset(AppIcons.categoryIcon,color: AppColor.primaryColor,),
            title: Text(widget.mainCategoryName,style:  Theme.of(context).textTheme.headline5!.copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.bold,fontSize: 16),),

            trailing: Icon(Icons.arrow_forward_ios,color: AppColor.primaryColor,),
          ),
        ),
        replacement: AnimatedContainer(
          duration: Duration(milliseconds:1),
          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.primaryColor,
          ),
          child: ListTile(
            leading:  SvgPicture.asset(AppIcons.categoryIcon,color: AppColor.white,),
            title: Text(widget.mainCategoryName,style:  Theme.of(context).textTheme.headline5!.copyWith(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 16),),

            trailing: Icon(Icons.arrow_downward,color: AppColor.white,),
          ),
        ),
      );
  },
),
    );
  }
}
