import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/router/app_router_names.dart';
import 'package:temp/presentation/widgets/app_bars/app_bar_with_icon.dart';
import 'package:temp/presentation/widgets/common_texts/green_text.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:temp/presentation/widgets/goals_widgets/note_widget.dart';
import 'package:temp/presentation/widgets/show_dialog.dart';

class AddGoalScreen extends StatelessWidget with AlertDialogMixin {
  AddGoalScreen({Key? key}) : super(key: key);
  final TextEditingController goalNameCtrl = TextEditingController();
  final TextEditingController goalCostCtrl = TextEditingController();
  final TextEditingController goalSaveRepeatAmount = TextEditingController();
  final _addGoalKey = GlobalKey<FormState>();

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
              SizedBox(
                height: 6.h,
              ),
              AppBarWithIcon(
                titleIcon: AppIcons.moneyAppBar,
                titleName: 'Time to save money',
                firstIcon: Icons.arrow_back_ios,
                actionIcon: '',
              ),
              bodyContent(goalsCubit, context)
            ],
          ),
        ),
      )
    );
  }

  Widget bodyContent(GoalsCubit goalsCubit, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.0.h,
                      ),
                      const GoalNote(),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Center(
                          child: SvgPicture.asset(AppIcons.savingMoneyCute,
                              height: 25.h, width: 70.w)),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      GreenText(text: 'Goal'),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      EditableInfoField(
                          textEditingController: goalNameCtrl,
                          hint: 'Buy New Mobile',

                         // containerWidth: double.infinity,
                          iconName: AppIcons.medalStar),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      GreenText(text: 'Goal Cost'),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      EditableInfoField(
                          textEditingController: goalCostCtrl,
                          keyboardType: TextInputType.number,
                          hint: '2000 LE',
                         // containerWidth: double.infinity,
                          iconName: AppIcons.dollarCircle),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      GreenText(text: 'Saving Style'),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      BlocBuilder<GoalsCubit, GoalsState>(
                        builder: (context, state) {
                          return EditableInfoField(
                            textEditingController: goalSaveRepeatAmount,
                            keyboardType: TextInputType.number,
                            hint: '15 LE',
                           // containerWidth: double.infinity,
                            iconName: AppIcons.cartAdd,
                            trailing: DropDownCustomWidget(
                              leadingIcon: '',
                              dropDownList: goalsCubit.dropDownChannelItems,
                              hint: goalsCubit.choseRepeat,
                              isExpanded: false,
                              backgroundColor: Colors.transparent,
                              icon: AppIcons.forwardArrow,
                              onChangedFunc: goalsCubit.chooseRepeat,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      GreenText(text: 'First Saving Day'),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      chooseDateWidget(goalsCubit),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Container(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                              onPressed: () async {
                                await validateAndAddGoal(context, goalsCubit);
                              },
                              child: Text(
                                'Save',
                                style: Theme.of(context).textTheme.bodyText1,
                              ))),
                      SizedBox(
                        height: 2.0.h,
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget chooseDateWidget(GoalsCubit goalCubit) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            goalCubit.changeDate(context);

            print('Choosed Date is ${goalCubit.chosenDate}');
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(.2),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                title: goalCubit.chosenDate == null
                    ? Text(
                        'Choose Date',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 13),
                      )
                    : Text(
                        '${goalCubit.chosenDate!.day} \\ ${goalCubit.chosenDate!.month} \\ ${goalCubit.chosenDate!.year}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 13),
                      ),
                leading: SvgPicture.asset(AppIcons.dateIcon),
              ),
            ),
          ),
        );
      },
    );
  }

  validateAndAddGoal(BuildContext context, GoalsCubit goalCubit) async {
    if (_addGoalKey.currentState!.validate()) {
      final GoalModel goalModel = GoalModel.copyWith(
          goalComment: 'goalComment',
          goalCreatedDay: DateTime.now(),
          id: GUIDGen.generate(),
          goalName: goalNameCtrl.text,
          goalRemainingAmount: 0,
          //num.tryParse(goalCostCtrl.text)!,
          goalRemainingPeriod: goalCubit.remainingTimes(
              cost: num.tryParse(goalCostCtrl.text)!,
              dailySaving: num.tryParse(goalSaveRepeatAmount.text)!),
          goalSaveAmount: num.tryParse(goalSaveRepeatAmount.text)!,
          goalSaveAmountRepeat: goalCubit.choseRepeat,
          goalTotalAmount: 2050,
          //num.tryParse(goalCostCtrl.text)!,
          goalStartSavingDate: goalCubit.chosenDate ?? DateTime.now(),
          goalCompletionDate: goalCubit.getCompletionDate(
              cost: num.tryParse(goalCostCtrl.text)!,
              dailySavings: num.tryParse(goalSaveRepeatAmount.text)!,
              repeat: goalCubit.choseRepeat,
              startSavingDate: goalCubit.chosenDate ?? DateTime.now()));
      await showGoalsDialog(
          context: context,
          onPressedYesFunction: () async {
            await goalCubit.addGoal(goalModel: goalModel).then((_) {
              showDialogAndNavigate(context);
            });
          },
          onPressedNoFunction: () {
            Navigator.of(context).pop();
          },
          infoMessage: goalCubit.dialogMessage(goalModel));
    }
  }

  showDialogAndNavigate(BuildContext context) {
    Navigator.pop(context);
    showSuccessfulDialog(
        context, 'Goal Added', 'You have successfully added goal');
    Future.delayed(
      Duration(seconds: 1),

      () {

       // Navigator.pop(context);
        Navigator.pushReplacementNamed(
            context, AppRouterNames.rGetGoals);
      },
    );
  }
}
