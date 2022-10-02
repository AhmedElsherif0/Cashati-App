import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/presentation/styles/colors.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/language_manager.dart';
import '../../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Column(
        children: [
          CustomAppBar(
            title: 'Home',
            onTapBack: () {},
            onTanNotification: () {},
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 5, // Space between underline and text
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Expenses",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 5, // Space between underline and text
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Income",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Stack(
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
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Show expenses',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.underline),
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
                            offset: Offset(0, 4), // changes position of shadow
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
                            SizedBox(height: 20,),
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
                            dashPattern: [3, 6],
                            borderType: BorderType.RRect,
                            padding: const EdgeInsets.only(
                                left: 60, right: 60, top: 25, bottom: 25),
                            radius: const Radius.circular(10),
                            child: const Text(
                              'Top Expense',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SvgPicture.asset('assets/icons/plus.svg')
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
