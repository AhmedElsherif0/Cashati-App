import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/widgets/common_texts/decorated_text.dart';

import '../../../constants/app_icons.dart';
import '../../../constants/app_strings.dart';
import '../../../data/local/cache_helper.dart';
import '../../widgets/buttons/elevated_button.dart';
import '../../widgets/dorp_downs_buttons/drop_down_button.dart';
import '../../widgets/gradiant_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _onPressNext(context) async {
    await CacheHelper.saveDataSharedPreference(key: 'onWelcome', value: true);
    Navigator.pushNamed(context, AppRouterNames.rOnBoardingRoute);
  }

  Future<void> changeLanguageTo(String languageCode, context) async {
    await translator.setNewLanguage(context,
        restart: false, newLanguage: languageCode);
    BlocProvider.of<GlobalCubit>(context)
        .onChangeLanguage(translator.activeLanguageCode == 'ar');
    print(translator.activeLanguageCode);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headLine3 = textTheme.headline3?.copyWith(fontSize: 18.dp);
    final GlobalCubit globalCubit = context.read<GlobalCubit>();
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) => GradiantBackground(
        stops: AppDecorations.welcomeStops,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.dp),
          child: Center(
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
                        Text(AppStrings.language.tr(), style: headLine3),
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
                                    onPress: !globalCubit.isLanguage
                                        ? () {}
                                        : () async =>
                                            await changeLanguageTo('ar', context),
                                    boxDecoration: globalCubit.isLanguage
                                        ? const BoxDecoration()
                                        : AppDecorations.decoratedTextDecoration()),
                                const Spacer(),
                                DecoratedText(
                                    text: AppStrings.english.tr(),
                                    onPress: globalCubit.isLanguage
                                        ? () {}
                                        : () async =>
                                            await changeLanguageTo('en', context),
                                    boxDecoration: globalCubit.isLanguage
                                        ? AppDecorations.decoratedTextDecoration()
                                        : const BoxDecoration()),
                                const Spacer(flex: 2),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.currency.tr(), style: headLine3),
                      SizedBox(height: 2.h),
                      WelcomeDropDownButton(
                        isDirection: translator.isDirectionRTL(context),
                        items: globalCubit.getCurrency,
                        selectedValue: globalCubit.selectedCurrency.tr(),
                        onChange: (value) => globalCubit.onChangeCurrency(value),
                      )
                    ],
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () => _onPressNext(context),
                  text: AppStrings.skip.tr(),
                  borderRadius: 6.dp,
                  width: 85.w,
                  height: 6.h,
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
