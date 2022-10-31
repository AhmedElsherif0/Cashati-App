import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';

import '../../widgets/custom_text_button.dart';
import '../../widgets/show_dialog.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with AlertDialogMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Image(
                        image: AssetImage("assets/images/loading.gif"),
                        gaplessPlayback: true,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 22.w,
                        height: 8.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 4.5.sp,
                          color: AppColor.mintGreen,
                          backgroundColor: AppColor.pineGreen,
                        ),
                      ),
                    ),
                    Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        setState(() {
                          showLoadingDialog(context);
                        });
                      },
                      text: 'open dialog',
                    )
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
