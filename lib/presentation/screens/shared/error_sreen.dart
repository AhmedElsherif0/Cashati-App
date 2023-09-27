import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_images.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/utils/extensions.dart';

import '../../../constants/app_strings.dart';
import '../../widgets/buttons/elevated_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 5),
            Expanded(flex: 10, child: Image.asset(AppImages.robotAssistantError)),
            const Spacer(),
            Expanded(
              child: Text(
                AppStrings.pageNotFound.tr(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: AppStrings.back.tr(),
                onPressed: () => context.pops,
                icon: Icons.arrow_back_ios,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: AppStrings.report.tr(),
                onPressed: () {},
                icon: Icons.error,
                backgroundColor: AppColor.red,
              ),
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
