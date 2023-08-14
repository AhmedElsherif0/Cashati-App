import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../constants/app_strings.dart';
import '../../widgets/buttons/elevated_button.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 5),
            const Expanded(
              flex: 10,
              child: Image(
                image: AssetImage('assets/images/empty_Gif.gif'),
                gaplessPlayback: true,
              ),
            ),
            Expanded(
              child: Text(AppStrings.noExpensesYet.tr(),
                  style: Theme.of(context).textTheme.headline3),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                  text: AppStrings.back.tr(), onPressed: () {}, icon: translator.activeLanguageCode == 'en' ?
                Icons.arrow_back_ios :Icons.arrow_forward_ios),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                  text: AppStrings.add.tr(), onPressed: () {}, icon: Icons.add),
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
