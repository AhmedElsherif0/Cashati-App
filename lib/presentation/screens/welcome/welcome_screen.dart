import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/data/models/onbaording/onbaording_list_of_data.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/widgets/common_texts/decorated_text.dart';

import '../../../constants/app_icons.dart';
import '../../../constants/app_strings.dart';
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

  Future<void> changeLanguageTo(String languageCode, context) async {
    await translator.setNewLanguage(context,
        restart: false, remember: true, newLanguage: languageCode);
    BlocProvider.of<GlobalCubit>(context)
        .changeLanguage(translator.activeLanguageCode == 'ar');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headLine3 = textTheme.headline3?.copyWith(fontSize: 18.dp);
    return GradiantBackground(
      stops: const [0.0, 0.087, 0.90, 1.5],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.dp),
        child: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            final GlobalCubit globalCubit = BlocProvider.of<GlobalCubit>(context);
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.welcomeTo.tr(), style: textTheme.headline1),
                        SizedBox(height: 2.h),
                        SizedBox(
                            width: 50.w,
                            child: SvgPicture.asset(AppIcons.cashatiLogoSVG)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( AppStrings.language.tr(), style: headLine3),
                        SizedBox(height: 2.h),
                        DecoratedBox(
                          decoration: AppDecorations.languageDecoration,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0.dp),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                const Spacer(flex: 2),
                                DecoratedText(
                                    text: AppStrings.arabic.tr(),
                                    onPress: globalCubit.isLanguage
                                        ? () {}
                                        : () => changeLanguageTo('ar', context),
                                    boxDecoration: globalCubit.isLanguage
                                        ? AppDecorations.decoratedTextDecoration
                                        : const BoxDecoration()),
                                const Spacer(),
                                DecoratedText(
                                    text: AppStrings.english.tr(),
                                    onPress: !globalCubit.isLanguage
                                        ? () {}
                                        : () => changeLanguageTo('en', context),
                                    boxDecoration: globalCubit.isLanguage
                                        ? const BoxDecoration()
                                        : AppDecorations.decoratedTextDecoration),
                                const Spacer(flex: 2),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.currency.tr(), style: headLine3),
                        SizedBox(height: 2.h),
                        DefaultDropDownButton(
                          isDirection: translator.isDirectionRTL(context),
                          items: OnBoardingData().getCurrency,
                          selectedValue: AppStrings.chooseCurrency.tr(),
                        )
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    onPressed: () => onPressNext(context),
                    text:AppStrings.skip.tr(),
                    borderRadius: 6.dp,
                    width: 85.w,
                    height: 6.h,
                  ),
                  const Spacer()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
