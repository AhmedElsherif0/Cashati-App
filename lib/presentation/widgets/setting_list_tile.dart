import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class SettingListTile extends StatefulWidget {
  SettingListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.onChangedFunc,
      required this.isTrail,
      this.switchValue = false,
      required this.icon,
      this.onTapReminder,
      this.isReminder = false,
      this.dateTime = '',
      this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final String dateTime;
  final String icon;
  final Function(bool)? onChangedFunc;
  final void Function()? onTap;
  final void Function()? onTapReminder;
  final bool isTrail;
  final bool isReminder;
  bool? switchValue;

  @override
  State<SettingListTile> createState() => _SettingListTileState();
}

class _SettingListTileState extends State<SettingListTile> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: widget.onTap ?? () {},
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset(widget.icon,
              color: AppColor.pineGreen, height: 30, width: 30),
        ),
        title: Text(widget.title,
            style: textTheme.headline3!
                .copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
        subtitle: widget.isReminder
            ? RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: widget.subtitle,
                      style: textTheme.subtitle1!.copyWith(fontSize: 13.dp)),
                  TextSpan(
                      text: widget.dateTime,
                      style: textTheme.subtitle1!.copyWith(fontSize: 13.dp)),
                ]),
              )
            : Text(widget.subtitle,
                style: textTheme.subtitle1!.copyWith(fontSize: 13.dp)),
        trailing: widget.isTrail
            ? Visibility(
                visible: !widget.isReminder,
                child: Switch.adaptive(
                  value: widget.switchValue!,
                  onChanged: widget.onChangedFunc == () {}
                      ? (val) {
                          setState(() => widget.switchValue = val);
                          widget.onChangedFunc!(val);
                        }
                      : widget.onChangedFunc,
                  activeColor: AppColor.primaryColor,
                ),
                replacement: IconButton(
                    onPressed: widget.onTapReminder, icon: Icon(Icons.timer_outlined)),
              )
            : null,
      ),
    );
  }
}
