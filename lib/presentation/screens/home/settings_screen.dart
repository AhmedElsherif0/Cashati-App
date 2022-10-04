import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/setting_card_layout.dart';

import '../../widgets/setting_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppStrings.settings,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.categoriesSetting,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SettingCardLayout(
                    settingChild: SettingListTile(
                  icon: AppIcons.editCategoryIcon,
                  title: AppStrings.editCategories,
                  subtitle: AppStrings.editCategoriesSubtitle,
                  isTrail: false,
                )),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  AppStrings.remindersSetting,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SettingCardLayout(
                    settingChild: Column(
                  children: [
                    SettingListTile(
                      icon: AppIcons.reminderIcon,
                      title: AppStrings.dailyReminders,
                      subtitle: AppStrings.reminderSubtitle,
                      isTrail: true,
                      switchValue: false,
                      onChangedFunc: (value) {},
                    ),
                    greenDivider(),
                    SettingListTile(
                      icon: AppIcons.notificationSettingIcon,
                      title: AppStrings.notifications,
                      subtitle: AppStrings.enableAlerts,
                      isTrail: true,
                      switchValue: false,
                      onChangedFunc: (value) {},
                    ),
                  ],
                )),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  AppStrings.moreInfoSetting,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SettingCardLayout(
                    settingChild: Column(
                  children: [
                    SettingListTile(
                      icon: AppIcons.languageSettingIcon,
                      title: AppStrings.languageSetting,
                      subtitle: AppStrings.englishSettingUsa,
                      isTrail: false,
                    ),
                    greenDivider(),
                    SettingListTile(
                      icon: AppIcons.currencySettingsIcon,
                      title: AppStrings.currencySetting,
                      subtitle: AppStrings.currencyEgp,
                      isTrail: false,
                    ),
                  ],
                )),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  AppStrings.appInfoSetting,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SettingCardLayout(
                    settingChild: Column(
                      children: [
                        SettingListTile(
                          icon: AppIcons.languageSettingIcon,
                          title: AppStrings.languageSetting,
                          subtitle: AppStrings.englishSettingUsa,
                          isTrail: true,
                          switchValue: false,
                          onChangedFunc: (value) {},
                        ),
                        greenDivider(),
                        SettingListTile(
                          icon: AppIcons.currencySettingsIcon,
                          title: AppStrings.currencySetting,
                          subtitle: AppStrings.currencyEgp,
                          isTrail: true,
                          switchValue: false,
                          onChangedFunc: (value) {},
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  Divider greenDivider() {
    return Divider(
      color: AppColor.dividerColor.withOpacity(.7),
      thickness: 2,
      indent: 14.3,
      endIndent: 14.3,
    );
  }
}