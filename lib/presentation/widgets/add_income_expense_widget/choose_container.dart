import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_icons.dart';

class DateChooseContainer extends StatefulWidget {
   DateChooseContainer({Key? key,required this.dateTime}) : super(key: key);
   DateTime? dateTime;
  @override
  _DateChooseContainerState createState() => _DateChooseContainerState();
}

class _DateChooseContainerState extends State<DateChooseContainer> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        chooseDate();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            title:widget.dateTime==null?Text('Choose Date',
              style:  Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ):Text('${widget.dateTime!.day} \\ ${widget.dateTime!.month} \\ ${widget.dateTime!.year}',
              style:  Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ),
            leading:  SvgPicture.asset(AppIcons.dateIcon),
          ),
        ),
      ),
    );

  }
  Future chooseDate()async{
    DateTime choosedDate;
     widget.dateTime=await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    );
     setState(() {
       widget.dateTime;
     });
  }
}
