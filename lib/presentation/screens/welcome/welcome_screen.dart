import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/data/models/onbaording/onbaording_list_of_data.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/widgets/decorated_text.dart';

import '../../../constants/app_icons.dart';
import '../../../data/local/cache_helper.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/expenses_and_income_widgets/drop_down_button.dart';
import '../../widgets/gradiant_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void onPressNext(context) async {
    await CacheHelper.saveDataSharedPreference(key: 'onWelcome', value: true);
    Navigator.pushNamed(context, AppRouterNames.rOnBoardingRoute);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return GradiantBackground(
      stops: const [0.0, 0.087, 0.90, 1.5],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome To', style: textTheme.headline1),
                    SizedBox(
                        width: 40.w, child: SvgPicture.asset(AppIcons.cashatiLogoSVG)),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: BlocBuilder<GlobalCubit, GlobalState>(
                  builder: (context, state) {
                    final GlobalCubit globalCubit =
                    BlocProvider.of<GlobalCubit>(context);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Language', style: textTheme.headline2),
                        SizedBox(height: 2.h),
                        DecoratedBox(
                          decoration: AppDecorations.languageDecoration,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0.sp),
                            child: Row(
                              children: [
                                const Spacer(flex: 2),
                                DecoratedText(
                                    text: 'English',
                                    onPress: () =>
                                        globalCubit
                                            .changeLanguage(!globalCubit.isEnglish),
                                    boxDecoration: globalCubit.isEnglish
                                        ? AppDecorations.decoratedTextDecoration
                                        : const BoxDecoration()),
                                const Spacer(),
                                DecoratedText(
                                    text: 'Arabic',
                                    onPress: () =>
                                        globalCubit
                                            .changeLanguage(globalCubit.isEnglish),
                                    boxDecoration: globalCubit.isEnglish
                                        ? const BoxDecoration()
                                        : AppDecorations.decoratedTextDecoration),
                                const Spacer(flex: 2),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Currency', style: textTheme.headline2),
                    SizedBox(height: 2.h),
                    DefaultDropDownButton(
                      items: OnBoardingData().getCurrency,
                      selectedValue: 'Choose Currency',
                    )
                  ],
                ),
              ),
              CustomElevatedButton(
                onPressed: () => onPressNext(context),
                text: 'Next',
                borderRadius: 6.sp,
                width: 80.w,
                height: 6.h,
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}