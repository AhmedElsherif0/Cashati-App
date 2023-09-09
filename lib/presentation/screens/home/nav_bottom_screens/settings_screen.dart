import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/widgets/setting_card_layout.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../widgets/buttons/custom_text_button.dart';
import '../../../widgets/custom_divder.dart';
import '../../../widgets/setting_choosen_component.dart';
import '../../../widgets/setting_list_tile.dart';

class SettingsScreen extends StatelessWidget with AlertDialogMixin {
  const SettingsScreen({Key? key}) : super(key: key);

  Future<void> _choseLanguage(String languageCode, context) async {
    await translator.setNewLanguage(context,
        restart: false, remember: true, newLanguage: languageCode);
    BlocProvider.of<GlobalCubit>(context)
        .onChangeLanguage(translator.activeLanguageCode == languageCode);
  }

  void onLanguageTap(context, globalCubit) {
    globalCubit.isEnglish = false;
    globalCubit.isArabic = false;
    showSettingDialog(
      context: context,
      child: UiDialogComponent(
        header: '${AppStrings.select.tr()} ${AppStrings.language.tr()}',
        firstIcon: AppIcons.englishLang,
        secondIcon: AppIcons.arabicLang,
        firstTitle: AppStrings.english.tr(),
        secondTitle: AppStrings.arabic.tr(),
        onTapFirst: () => globalCubit.swapLangBGColor(true),
        onTapSecond: () => globalCubit.swapLangBGColor(false),
        onPressOK: () async {
          Navigator.of(context).pop();
          if (globalCubit.isEnglish || globalCubit.isArabic) {
            await _choseLanguage(globalCubit.isEnglish ? 'en' : 'ar', context);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalCubit = context.read<GlobalCubit>();
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.categories.tr(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 10.0),
                SettingCardLayout(
                    settingChild: SettingListTile(
                  icon: AppIcons.editCategoryIcon,
                  title: AppStrings.editCategories.tr(),
                  subtitle: '${AppStrings.income.tr()} / ${AppStrings.expense.tr()}',
                  isTrail: false,
                )),
                const SizedBox(height: 10.0),
                Text(
                  AppStrings.reminders.tr(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 10.0),
                // Todo: change the List tile to date Picker.
                /// ReminderDate should be Date Picker
                SettingCardLayout(
                  settingChild: Column(
                    children: [
                      SettingListTile(
                        icon: AppIcons.reminder,
                        title: AppStrings.dailyReminders.tr(),
                        subtitle: AppStrings.reminderSubtitle.tr(),
                        dateTime: AppStrings.reminderTime.tr(),
                        isTrail: true,
                        isReminder: true,
                        switchValue: false,
                        onChangedFunc: (value) {},
                      ),
                      const CustomDivider(),
                      BlocBuilder<GlobalCubit, GlobalState>(
                        builder: (context, state) {
                          return SettingListTile(
                            icon: AppIcons.notificationSetting,
                            title: AppStrings.notifications.tr(),
                            subtitle: globalCubit.isEnable
                                ? AppStrings.disableAlerts.tr()
                                : AppStrings.enableAlerts.tr(),
                            isTrail: true,
                            switchValue: globalCubit.isEnable,
                            onChangedFunc: (value) =>
                                globalCubit.enableNotifications(value: value),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  AppStrings.moreSettings.tr(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 10.0),

                /// Language Card.
                SettingCardLayout(
                  settingChild: Column(
                    children: [
                      SettingListTile(
                        icon: AppIcons.englishLang,
                        title: AppStrings.language.tr(),
                        subtitle: AppStrings.englishSettingUsa.tr(),
                        isTrail: false,
                        onTap: () => onLanguageTap(context, globalCubit),
                      ),
                      const CustomDivider(),

                      /// Currency Card
                      SettingListTile(
                        icon: AppIcons.currencySettings,
                        title: AppStrings.currency.tr(),
                        subtitle: globalCubit.selectedValue.tr(),
                        isTrail: false,
                        onTap: () {
                          globalCubit.isEnglish = false;
                          globalCubit.isArabic = false;
                          showSettingDialog(
                            context: context,
                            child: UiDialogComponent(
                              header:
                                  '${AppStrings.select.tr()} ${AppStrings.currency.tr()}',
                              firstTitle: globalCubit.getCurrency[0].tr(),
                              secondTitle: globalCubit.getCurrency[1].tr(),
                              onTapFirst: () => globalCubit.swapCurrencyBGColor(true),
                              onTapSecond: () =>
                                  globalCubit.swapCurrencyBGColor(false),
                              onPressOK: () {
                                Navigator.of(context).pop();
                                if (globalCubit.isEnglish || globalCubit.isArabic) {
                                  globalCubit.changeCurrency();
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(AppStrings.appInfo.tr(),
                    style: Theme.of(context).textTheme.headline3!),
              ],
            ),
          ),
        ));
      },
    );
  }
}

class UiDialogComponent extends StatelessWidget {
  const UiDialogComponent({
    super.key,
    required this.onPressOK,
    required this.header,
    required this.firstTitle,
    required this.secondTitle,
    required this.onTapFirst,
    required this.onTapSecond,
    this.firstIcon,
    this.secondIcon,
  });

  final String firstTitle;
  final String secondTitle;
  final String? firstIcon;
  final String? secondIcon;
  final void Function() onTapFirst;
  final void Function() onTapSecond;
  final void Function() onPressOK;
  final String header;

  @override
  Widget build(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.dp, vertical: 16.dp),
          child: Column(
            crossAxisAlignment: globalCubit.isLanguage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Align(
                alignment: globalCubit.isLanguage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(header, style: Theme.of(context).textTheme.headline5),
              ),
              const Spacer(),
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    SettingsChosenComponent(
                        icon: firstIcon,
                        iconName: firstTitle,
                        isPressed: globalCubit.isEnglish,
                        onTap: onTapFirst),
                    const CustomDivider(),
                    SettingsChosenComponent(
                        icon: secondIcon,
                        iconName: secondTitle,
                        isPressed: globalCubit.isArabic,
                        onTap: onTapSecond),
                    const Spacer(flex: 2),
                    Row(
                      children: [
                        CustomTextButton(
                          text: AppStrings.cancel.tr(),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        CustomTextButton(
                            text: AppStrings.ok.tr(), onPressed: onPressOK),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
