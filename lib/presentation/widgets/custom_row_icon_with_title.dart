import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/colors.dart';

class RowIconWithTitle extends StatelessWidget {
  const RowIconWithTitle({
    required this.title,
    required this.startIcon,
    required this.toolTipMessage,
    Key? key,
    this.endIcon,
  }) : super(key: key);

  final String title;
  final String startIcon;
  final String toolTipMessage;
  final Widget? endIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child:
                    Tooltip(

                        message: toolTipMessage,
                        child: SvgPicture.asset(startIcon, color: AppColor.primaryColor)),
              ),
              const Spacer(),
              Expanded(
                flex: 8,
                child: Text(title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis),
              ),
              Expanded(
                flex: 2,
                child: Align(alignment: Alignment.centerRight, child: endIcon),
              ),
              const Spacer()
            ],
          ),
          const Spacer(),
          const Divider(color: AppColor.primaryColor, thickness: 1)
        ],
      ),
    );
  }
}
