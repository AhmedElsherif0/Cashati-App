import 'package:flutter/material.dart';
import 'package:temp/presentation/styles/colors.dart';
import '../../widgets/elevated_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 5),
            Expanded(
              flex: 10,
              child: Image.asset("assets/images/robot_assistant_error.png")
            ),
            const Spacer(),
            Expanded(
              child: Text(
                'Page not found',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: 'Back',
                onPressed: () {},
                icon: Icons.arrow_back_ios,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                text: 'Report',
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
