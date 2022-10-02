import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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
                height: 7.h,
              ),
              Stack(
                children: [
                  Container(
                    height: 55.h,
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white
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
