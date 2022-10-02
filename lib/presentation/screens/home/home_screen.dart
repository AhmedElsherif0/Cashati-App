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
import '../../../business_logic/home_cubit/home_cubit.dart';
import '../../../business_logic/home_cubit/home_state.dart';
import '../../../constants/language_manager.dart';
import '../../views/card_home.dart';
import '../../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
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
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 80),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.changeExpensesAndIncome();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 5, // Space between underline and text
                            ),
                            decoration: BoxDecoration(
                              border: cubit.isSelect ? const Border(
                                bottom: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ):null,
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
                          onTap: () {
                            cubit.changeExpensesAndIncome();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 5, // Space between underline and text
                            ),
                            decoration:  BoxDecoration(
                              border:!cubit.isSelect? const Border(
                                bottom: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ):null,
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
                  cubit.isSelect
                      ? CardHome(
                          title: "Expenses",
                          onTapPressed: () {},
                          onTapShow: () {},
                        )
                      : CardHome(
                          title: 'Income',
                          onTapPressed: () {},
                          onTapShow: () {},
                        )
                ],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
