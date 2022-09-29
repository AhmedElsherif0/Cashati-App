import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class CustomExpandableList extends StatelessWidget {
  const CustomExpandableList(
      {Key? key,
      required this.itemsText,
      required this.length,
      this.iconColor = Colors.deepOrange,
      required this.expandableText,
      this.backgroundColor,
      required this.children, this.leadingIcon})
      : super(key: key);

  final String expandableText;
  final String itemsText;
  final int length;
  final Color iconColor;
  final Color? backgroundColor;
  final List<Widget> children;
  final Icon? leadingIcon;

  Icon arrowIcon() => const Icon(Icons.arrow_forward_ios_outlined,
      color: AppColor.primaryColor);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                border: Border.all(color: AppColor.primaryColor, width: 1),
                color: backgroundColor),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 20.sp),
              iconColor: iconColor,
              backgroundColor: AppColor.white,
              title: Text(expandableText,
                  style: const TextStyle(
                      fontSize: 20, color: AppColor.primaryColor),
                  textAlign: TextAlign.start),
              trailing: arrowIcon(),
              leading: leadingIcon,
              children: children.isNotEmpty
                  ? children
                  : List<Widget>.generate(
                      length,
                      (_) => Row(
                        children: [
                          const Spacer(),
                          Text(
                            itemsText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: AppColor.primaryColor),
                          ),
                          const Spacer(flex: 8),
                          arrowIcon(),
                          const Spacer(),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }


}
