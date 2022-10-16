import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/widgets/expenses_and_income_widgets/underline_text_button.dart';

import '../styles/colors.dart';
import '../widgets/cancel_confirm_text_button.dart';
import '../widgets/custom_row_icon_with_title.dart';

class ConfirmPayingCard extends StatelessWidget {
  const ConfirmPayingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        /// must be child for a Expanded Widget.
        Expanded(
          child: Card(
            elevation: 8.sp,
            color: AppColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.sp)),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.sp),
                              topRight: Radius.circular(24.sp))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Expense3',
                            style: textTheme.headline5
                                ?.copyWith(color: AppColor.white)),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: RowIconWithTitle(
                      startIcon: AppIcons.categories, title: 'Family'),
                ),
                Expanded(
                  child: RowIconWithTitle(
                    startIcon: AppIcons.poundSterlingSign,
                    title: '300 LE',
                    endIcon: SvgPicture.asset(AppIcons.editIcon,
                        color: AppColor.primaryColor),
                  ),
                ),
                const Expanded(
                  child: RowIconWithTitle(
                      startIcon: AppIcons.calender, title: '23 / 04/ 2022'),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.exclamationMark,
                                  color: AppColor.primaryColor,
                                ),
                                UnderLineTextButton(
                                    onPressed: () {},
                                    text: 'Details',
                                    textStyle: textTheme.headline6),
                              ],
                            ),
                          ),
                          const Spacer(flex: 4),
                          Expanded(
                            flex: 3,
                            child: SvgPicture.asset(
                              AppIcons.delete,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
                      CancelConfirmTextButton(
                        onCancel: () {},
                        onConfirm: () {},
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
