import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/constants/app_images.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/styles/decorations.dart';
import 'package:temp/presentation/utils/extensions.dart';
import 'package:temp/presentation/views/app_bar_with_icon.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/common_texts/green_text.dart';
import 'package:temp/presentation/widgets/dorp_downs_buttons/goals_drop_down.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:temp/presentation/widgets/goals_widgets/note_widget.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

import '../../data/repository/formats_mixin.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen>
    with AlertDialogMixin, FormatsMixin {
  final TextEditingController goalNameCtrl = TextEditingController();
  final TextEditingController goalCostCtrl = TextEditingController();
  final TextEditingController goalSaveRepeatAmount = TextEditingController();
  final TextEditingController goalComment = TextEditingController();
  final _addGoalKey = GlobalKey<FormState>();

  _validateAndAddGoal(BuildContext context, GoalsCubit goalCubit) async {
    if (goalCubit.chosenDate == null) {
      return _showErrorSnackBar(context, message: AppStrings.chooseDay);
    }
    if (_addGoalKey.currentState!.validate()) {
      //TODO put goal comment text form field

      final GoalModel goalModel = GoalModel.copyWith(
          goalComment: goalComment.text,
          goalCreatedDay: DateTime.now(),
          id: GUIDGen.generate(),
          goalName: goalNameCtrl.text,
          goalRemainingAmount: goalCubit.countRemainingAmount(
              num.tryParse(goalCostCtrl.text) ?? 0,
              num.tryParse(goalSaveRepeatAmount.text) ?? 0),
          //num.tryParse(goalCostCtrl.text)!,
          goalRemainingPeriod: goalCubit.remainingTimes(
              cost: num.tryParse(goalCostCtrl.text) ?? 0,
              dailySaving: num.tryParse(goalSaveRepeatAmount.text) ?? 0),
          goalSaveAmount: num.tryParse(goalSaveRepeatAmount.text) ?? 0,
          goalSaveAmountRepeat: goalCubit.repeatDatabaseEntries(),
          goalTotalAmount: num.parse(goalCostCtrl.text),
          //num.tryParse(goalCostCtrl.text)!,
          goalStartSavingDate: goalCubit.chosenDate ?? goalCubit.today,
          goalCompletionDate: goalCubit.getCompletionDate(
              cost: num.tryParse(goalCostCtrl.text) ?? 0,
              dailySavings: num.tryParse(goalSaveRepeatAmount.text) ?? 0,
              repeat: goalCubit.repeatDatabaseEntries(),
              startSavingDate: goalCubit.chosenDate ?? goalCubit.today));
      await showGoalsDialog(
          context: context,
          onPressedYesFunction: () async {
            await goalCubit.addGoal(goalModel: goalModel).then((_) {
              _showSuccessSnackBar(context);
            }).onError((error, stackTrace) {
              _showErrorSnackBar(context);
            });
          },
          infoMessage: goalCubit.dialogMessage(
              cost: goalCostCtrl.text.toNum()!,
              dailySaving: goalSaveRepeatAmount.text.tr().toNum()!));
    } else {
      _showErrorSnackBar(context, message: AppStrings.fillEmptyFields);
    }
  }

  void _showErrorSnackBar(BuildContext context,
          {String message = AppStrings.someThingWentWrong}) =>
      errorSnackBar(context: context, message: message.tr());

  void _showSuccessSnackBar(BuildContext context) {
    Navigator.of(context).pop();
    showSuccessfulDialog(context, AppStrings.successfullyConfirmedExpenseFood.tr());
    Future.delayed(const Duration(seconds: 3), () => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    GoalsCubit goalsCubit = BlocProvider.of<GoalsCubit>(context);
    return Scaffold(
      body: Form(
        key: _addGoalKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h),
              AppBarWithIcon(
                onTapFirstIcon: () {
                  Navigator.of(context).pop();
                  goalsCubit.fetchAllGoals();
                },
                titleIcon: AppIcons.moneyAppBar,
                titleName: AppStrings.timeToSaveMoney.tr(),
                firstIcon: Icons.arrow_back_ios,
                actionIcon: '',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.0.h),
                      const GoalNote(),
                      SizedBox(height: 1.0.h),
                      Center(
                          child: Image.asset(AppImages.savingMoney,
                              height: 25.h, width: 70.w)),
                      SizedBox(height: 2.0.h),
                      GreenText(text: AppStrings.goal.tr()),
                      SizedBox(height: 1.0.h),
                      EditableInfoField(
                          textEditingController: goalNameCtrl,
                          hint: AppStrings.buyNewMobile.tr(),
                          backGroundColor: AppColor.pinkishGrey.withOpacity(0.25),
                          iconName: AppIcons.medalStar),
                      SizedBox(height: 2.0.h),
                      GreenText(text: AppStrings.goalCost.tr()),
                      SizedBox(height: 1.0.h),
                      EditableInfoField(
                          textEditingController: goalCostCtrl,
                          keyboardType: TextInputType.number,
                          hint: AppStrings.twoThousand.tr(),
                          backGroundColor: AppColor.pinkishGrey.withOpacity(0.25),
                          iconName: AppIcons.dollarCircle),
                      SizedBox(height: 2.0.h),
                      GreenText(text: AppStrings.yourSaving.tr()),
                      SizedBox(height: 1.0.h),
                      BlocBuilder<GoalsCubit, GoalsState>(
                        builder: (context, state) {
                          return EditableInfoField(
                            textEditingController: goalSaveRepeatAmount,
                            keyboardType: TextInputType.number,
                            hint: AppStrings.fifteen.tr(),
                            backGroundColor: AppColor.pinkishGrey.withOpacity(0.25),
                            iconName: AppIcons.cartAdd,

                            /// Don't change any thing please :D
                            trailing: GoalsFilterWidget(
                              leadingIcon: '',
                              dropDownList: goalsCubit.dropDownChannelItems,
                              hint: goalsCubit.choseRepeat.tr(),
                              isExpanded: false,
                              value: goalsCubit.choseRepeat.tr(),
                              backgroundColor: Colors.transparent,
                              iconWidget: Icon(Icons.arrow_forward_ios,
                                  color: AppColor.primaryColor, size: 16.dp),
                              onChangedFunc: (value) => goalsCubit.chooseRepeat(value),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 2.0.h),
                      GreenText(text: AppStrings.firstSavingDay.tr()),
                      SizedBox(height: 1.0.h),
                      const ChooseDateWidget(),
                      SizedBox(height: 2.0.h),
                      CustomElevatedButton(
                          height: 6.h,
                          width: 90.w,
                          borderRadius: 8.dp,
                          onPressed: () async =>
                              await _validateAndAddGoal(context, goalsCubit),
                          text: AppStrings.save.tr()),
                      SizedBox(height: 2.0.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseDateWidget extends StatelessWidget with FormatsMixin {
  const ChooseDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GoalsCubit goalsCubit = BlocProvider.of<GoalsCubit>(context);
    return BlocBuilder<GoalsCubit, GoalsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            await goalsCubit.changeDate(context);
            print('Choosed Date is ${goalsCubit.chosenDate}');
          },
          child: DecoratedBox(
            decoration: AppDecorations.editTextDecoration(
                AppColor.pinkishGrey.withOpacity(0.25)),
            child: ListTile(
              leading: SvgPicture.asset(AppIcons.dateIcon),
              title: Text(
                goalsCubit.chosenDate == null
                    ? AppStrings.chooseDate.tr()
                    : formatDayDate(
                        goalsCubit.chosenDate!, translator.activeLanguageCode),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
              ),
            ),
          ),
        );
      },
    );
  }
}
