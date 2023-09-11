import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_lists.dart';
import 'package:temp/presentation/styles/colors.dart';

import '../../constants/app_strings.dart';

class CashatiTeamWidget extends StatelessWidget {
  const CashatiTeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ExpansionTile(
        title: Text(AppStrings.cashatiTeam.tr()),
        leading: const Icon(Icons.monetization_on_outlined),
        iconColor: AppColor.primaryColor,
        children: AppConstantList.cashatiWorkers
            .map((employer) => ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.engineering_outlined),
                    const SizedBox(width: 20),
                    Text(employer.name,
                        style: textTheme.headline3!
                            .copyWith(fontSize: 15, fontWeight: FontWeight.w500))
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const PositionAndEmail(
                            position: 'Position : ', email: 'Email :'),
                        PositionAndEmail(
                            position: employer.jobTitle, email: employer.email)
                      ],
                    ),
                    const Divider(color: AppColor.grey)
                  ],
                )))
            .toList());
  }
}

class PositionAndEmail extends StatelessWidget {
  const PositionAndEmail({super.key, required this.position, required this.email});

  final String position;
  final String email;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Text(position,
            style: textTheme.subtitle1!.copyWith(fontSize: 10.dp), maxLines: 2),
        SizedBox(width: 1.h),
        Text(email,
            style: textTheme.subtitle1!.copyWith(fontSize: 10.dp), maxLines: 2),
      ],
    );
  }
}
