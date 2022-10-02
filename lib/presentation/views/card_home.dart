import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class CardHome extends StatelessWidget {
  const CardHome({Key? key, required this.title, required this.onTapShow, required this.onTapPressed}) : super(key: key);

  final String title;
  final Function() onTapShow;
  final Function()  onTapPressed;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            height: 50.h,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: onTapShow,
                  child: Text(
                    'Show $title',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 50,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, bottom: 30, top: 30),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/download.svg',
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Balance',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.primaryColor),
                  ),

                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: DottedBorder(
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                  dashPattern: const [3, 6],
                  borderType: BorderType.RRect,
                  padding: const EdgeInsets.only(
                      left: 60, right: 60, top: 25, bottom: 25),
                  radius: const Radius.circular(10),
                  child: Text(
                    'Top $title',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: onTapPressed,
                  child: SvgPicture.asset('assets/icons/plus.svg'))
            ],
          ),
        ),
      ],
    );
  }
}
