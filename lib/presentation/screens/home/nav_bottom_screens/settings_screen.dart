import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/setting_card_layout.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../../widgets/buttons/custom_text_button.dart';
import '../../../widgets/custom_divder.dart';
import '../../../widgets/setting_choosen_component.dart';
import '../../../widgets/setting_list_tile.dart';

class SettingsScreen extends StatelessWidget with AlertDialogMixin {
  const SettingsScreen({Key? key}) : super(key: key);

  Future<void> changeLanguageTo(String languageCode, context) async {
    await translator.setNewLanguage(context,
        restart: false, remember: true, newLanguage: languageCode);
    BlocProvider.of<GlobalCubit>(context)
        .changeLanguage(translator.activeLanguageCode == languageCode);
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
                        onTap: () {
                          globalCubit.isEnglish = false;
                          globalCubit.isArabic = false;
                          showSettingDialog(
                            context: context,
                            title: '',
                            child: ShowLanguageDialog(
                              onPressOK: () async {
                                Navigator.of(context).pop(true);
                                await changeLanguageTo(
                                    globalCubit.isEnglish ? 'en' : 'ar', context);
                              },
                            ),
                          );
                        },
                      ),
                      const CustomDivider(),
                      SettingListTile(
                        icon: AppIcons.currencySettings,
                        title: AppStrings.currency.tr(),
                        subtitle: AppStrings.egp.tr(),
                        isTrail: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  AppStrings.appInfo.tr(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}

class ShowLanguageDialog extends StatefulWidget {
  const ShowLanguageDialog({super.key, required this.onPressOK});

  final void Function() onPressOK;

  @override
  State<ShowLanguageDialog> createState() => _ShowLanguageDialogState();
}

class _ShowLanguageDialogState extends State<ShowLanguageDialog> {
  @override
  Widget build(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(8.dp),
          child: Column(
            crossAxisAlignment: globalCubit.isLanguage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text('${AppStrings.select.tr()} ${AppStrings.language.tr()}',
                  style: Theme.of(context).textTheme.headline3),
              const Spacer(),
              Expanded(
                flex: 8,
                child: Column(children: [
                  SettingsChosenComponent(
                      icon: AppIcons.englishLang,
                      iconName: AppStrings.english.tr(),
                      isPressed: globalCubit.isEnglish,
                      onTap: () {
                        globalCubit.changeLangBGColor(true);
                        setState(() {});
                      }),
                  const CustomDivider(),
                  SettingsChosenComponent(
                      icon: AppIcons.arabicLang,
                      iconName: AppStrings.arabic.tr(),
                      isPressed: globalCubit.isArabic,
                      onTap: () {
                        globalCubit.changeLangBGColor(false);
                        setState(() {});
                      }),
                  const Spacer(flex: 2),
                  Row(children: [
                    CustomTextButton(
                        text: AppStrings.cancel.tr(),
                        onPressed: () => Navigator.of(context).pop(false)),
                    CustomTextButton(
                        text: AppStrings.ok.tr(), onPressed: widget.onPressOK),
                  ]),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
