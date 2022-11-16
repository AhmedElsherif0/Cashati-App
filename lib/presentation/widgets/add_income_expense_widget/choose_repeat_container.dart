/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_icons.dart';

class RepeatChooseContainer extends StatefulWidget {
  RepeatChooseContainer({Key? key,required this.choosedRepeat}) : super(key: key);
  String? choosedRepeat;

  @override
  _RepeatChooseContainerState createState() => _RepeatChooseContainerState();
}

class _RepeatChooseContainerState extends State<RepeatChooseContainer> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            leading: Visibility(
              visible: widget.choosedRepeat!.isEmpty,
                child:Text('Choose Repeat',
                    style:  Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 13),

            ),
            replacement:Text('${widget.choosedRepeat!}',
              style:  Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ),


            ),
            trailing:  SvgPicture.asset(AppIcons.downArrow),
          ),
        ),
      ),
    );

  }

}*/
