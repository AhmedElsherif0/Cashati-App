import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/setting_list_tile.dart';

import '../../constants/app_icons.dart';

class CashatiTeamWidget extends StatelessWidget {
  const CashatiTeamWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text("Cashati Team"),leading: Icon(Icons.monetization_on_outlined),
      children:AppConstantList.cashatiWorkers.map((employer) =>         ListTile(title: Row(
        children: [
          Icon(Icons.engineering_outlined),
          const SizedBox(width: 20,),
          Text(employer.name, style: Theme.of(context).textTheme.headline3!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
          )],
      ),
          subtitle:
          Column(
            children: [
              Row(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: 1.h,),

                      Text("Position : ", style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10.dp),maxLines: 2),
                      SizedBox(width: 1.h,),

                      Text("Email : ", style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10.dp),maxLines: 2),

                    ],
                  ),
                  SizedBox(width: 1.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: 1.h,),

                      Text(employer.jobTitle, style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10.dp),maxLines: 2,),
                      SizedBox(width: 1.h,),
                      Text(employer.email, style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10.dp),maxLines: 2),
                    ],
                  ),
                ],
              ),
              Divider(color: AppColor.grey,)
            ],
          )

      )).toList()
    );

  }
}
