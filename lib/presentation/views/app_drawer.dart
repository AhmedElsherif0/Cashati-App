import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/utils/extensions.dart';
import 'package:temp/presentation/widgets/drawer_item.dart';
import 'package:temp/presentation/widgets/privacy_terms_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 65.w,
      shape: RoundedRectangleBorder(
          borderRadius: translator.activeLanguageCode == 'ar'
              ? AppDecorations.rightDrawer
              : AppDecorations.liftDrawer),
      child: Stack(
        children: [
          Column(
            children: [
              const Spacer(flex: 4),
              Expanded(
                flex: 3,
                child: DrawerItem(
                    icon: AppIcons.closeDrawer,
                    onTap: () => Navigator.of(context).pop()),
              ),
              const Spacer(flex: 2),
              Expanded(
                flex: 5,
                child: DrawerItem(
                  icon: AppIcons.expenseDrawer,
                  text: AppStrings.expenseTypes.tr(),
                  onTap: () => context.pushNamedTo(AppRouterNames.rExpenseRepeatType),
                ),
              ),
              Expanded(
                flex: 5,
                child: DrawerItem(
                  icon: AppIcons.incomeDrawer,
                  text: AppStrings.incomeTypes.tr(),
                  onTap: () => context.pushNamedTo(AppRouterNames.rIncomeRepeatType),
                ),
              ),
              Expanded(
                flex: 5,
                child: DrawerItem(
                  icon: AppIcons.goalsDrawer,
                  text: AppStrings.goals.tr(),
                  onTap: () => context.pushNamedTo(AppRouterNames.rGetGoals),
                ),
              ),
              Spacer(flex: 3),
              const Expanded(
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: PrivacyPolicyAndTermsWidget())),
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
