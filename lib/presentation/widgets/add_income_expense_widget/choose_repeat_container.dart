import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/app_strings.dart';

import '../../../constants/app_icons.dart';

// Todo: this Widget unused yet.
class RepeatChooseContainer extends StatefulWidget {
  RepeatChooseContainer({Key? key, required this.choosedRepeat}) : super(key: key);
  final String? choosedRepeat;

  @override
  _RepeatChooseContainerState createState() => _RepeatChooseContainerState();
}

class _RepeatChooseContainerState extends State<RepeatChooseContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            leading: Text(
              widget.choosedRepeat!.isEmpty
                  ? AppStrings.chooseRepeat
                  : '${widget.choosedRepeat!}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ),
            trailing: SvgPicture.asset(AppIcons.downArrow),
          ),
        ),
      ),
    );
  }
}
