/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return InkWell(
      onTap: (){
        setState(() {
          isChoosed=!isChoosed;
        });
        print('isChoosed ${isChoosed}');
      },
      child: Visibility(
        visible: !isChoosed,
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.primaryColor,width: 1),
            color: AppColor.white,
          ),
          duration: Duration(milliseconds:300),
          child: ListTile(
            leading:  SvgPicture.asset(AppIcons.categoryIcon,color: AppColor.primaryColor,),
            title: Text(widget.mainCategoryName,style:  Theme.of(context).textTheme.headline5!.copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.bold,fontSize: 16),),

            trailing: Icon(Icons.arrow_forward_ios,color: AppColor.primaryColor,),
          ),
        ),
        replacement: AnimatedContainer(
          duration: Duration(milliseconds:300),
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
      ),
    );
  }
}*/
