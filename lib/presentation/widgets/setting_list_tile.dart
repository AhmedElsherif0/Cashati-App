import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class SettingListTile extends StatefulWidget {
   SettingListTile({Key? key,required this.title,required this.subtitle, this.onChangedFunc,required this.isTrail,
      this.switchValue,required this.icon
   }) : super(key: key);
  final String title;
  final String subtitle;
  final String icon;
  final Function(bool)? onChangedFunc;
  final bool isTrail;
   bool? switchValue=false;

  @override
  State<SettingListTile> createState() => _SettingListTileState();
}

class _SettingListTileState extends State<SettingListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading:  Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SvgPicture.asset(widget.icon,color: AppColor.pineGreen,height: 30,width: 30,),
      ),
      title: Text(widget.title,
        style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15,fontWeight: FontWeight.w500),
      ),
      subtitle: Text(widget.subtitle,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 13),
      ) ,
      trailing: widget.isTrail? Switch.adaptive(
        value: widget.switchValue!, onChanged: (val){
       setState(() {
         widget.switchValue=val;
       });
       widget.onChangedFunc!(val);
      },
        activeColor: AppColor.primaryColor,
      ):null,
    );
  }
}
