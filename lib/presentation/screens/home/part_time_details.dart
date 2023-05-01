import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/widgets/custom_app_bar.dart';
import '../../../constants/app_icons.dart';
import '../../styles/colors.dart';
import '../../widgets/editable_text.dart';

class PartTimeDetails extends StatefulWidget {
  const PartTimeDetails({Key? key}) : super(key: key);

  @override
  State<PartTimeDetails> createState() => _PartTimeDetailsState();
}

class _PartTimeDetailsState extends State<PartTimeDetails> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.sp),
          const CustomAppBar(title: 'Food Expense Details', isEndIconVisible: false),
          SizedBox(height: 40.sp),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                EditableInfoField(
                  textEditingController: nameController,
                  hint: '23/04/2023',
                  iconName: AppIcons.calender,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.sp),
                EditableInfoField(
                  textEditingController: nameController,
                  hint: 'Home',
                  iconName: AppIcons.categoryIcon,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.sp),
                EditableInfoField(
                  textEditingController: nameController,
                  hint: 'Food',
                  iconName: AppIcons.categories,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.sp),
                EditableInfoField(
                  textEditingController: nameController,
                  hint: '500',
                  iconName: AppIcons.amountIcon,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.sp),
                EditableInfoField(
                  textEditingController: nameController,
                  hint: 'Weekly',
                  iconName: AppIcons.change,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.sp),
                EditableInfoField(
                  textEditingController: nameController,
                  hint:
                      'There are many variations of... There are many variations of...',
                  iconName: AppIcons.descriptionIcon,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 30.sp),
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 16.sp,
                    backgroundColor: AppColor.primaryColor,
                    child: SvgPicture.asset(AppIcons.delete, color: AppColor.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
