import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/presentation/widgets/buttons/elevated_button.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';

class AddGoalTestScreen extends StatelessWidget {
  AddGoalTestScreen({Key? key}) : super(key: key);

  final TextEditingController goalName = TextEditingController();

  final TextEditingController goalCost = TextEditingController();

  final TextEditingController savingAmount = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final goalCub = BlocProvider.of<GoalsCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              EditableInfoField(
                hint: 'Add Goal Name',
                iconName: AppIcons.amountIcon,
                textEditingController: goalName,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 50,),
              EditableInfoField(
                hint: 'Add Goal Cost',
                iconName: AppIcons.amountIcon,
                textEditingController: goalCost,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 50,),
              EditableInfoField(
                hint: 'Add Saving amount',
                iconName: AppIcons.amountIcon,
                textEditingController: savingAmount,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 50,),
              BlocBuilder<GoalsCubit, GoalsState>(
                builder: (context, state) {
                  return DropDownCustomWidget(
                      dropDownList:
                      goalCub.dropDownChannelItems,
                      hint: goalCub.choseRepeat,
                      onChangedFunc: goalCub.chooseRepeat);
                },
              ),
              SizedBox(height: 50,),
              chooseDateWidget(context,goalCub),
              SizedBox(height: 50,),
              CustomElevatedButton(
                  onPressed: () {
                    goalCub.addGoal(goalModel: GoalModel.copyWith(
                        goalComment: 'goalComment',
                        goalCreatedDay: DateTime.now(),
                        id: GUIDGen.generate(),
                        goalName: goalName.text,
                        goalRemainingAmount: num.tryParse(goalCost.text)!,
                        goalRemainingPeriod: goalCub.remainingTimes(
                            cost: num.tryParse(goalCost.text)!,
                            dailySaving: num.tryParse(savingAmount.text)!),
                        goalSaveAmount: num.tryParse(savingAmount.text)!,
                        goalSaveAmountRepeat: goalCub.choseRepeat,
                        goalTotalAmount: num.tryParse(goalCost.text)!,
                        goalStartSavingDate:goalCub.chosenDate??DateTime.now(),
                        goalCompletionDate: goalCub.getCompletionDate(cost: num.tryParse(goalCost.text)!,
                            dailySavings:  num.tryParse(savingAmount.text)!,
                            repeat: goalCub.choseRepeat,
                            startSavingDate: goalCub.chosenDate??DateTime.now())));
                  }, text: 'Add Goal')
            ],
          ),
        ),
      ),
    );
  }


  }
  Widget chooseDateWidget(BuildContext context,GoalsCubit goalCubit){
    return BlocBuilder<GoalsCubit, GoalsState>(
  builder: (context, state) {
    return InkWell(
      onTap: ()async{
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
            title:goalCubit.chosenDate==null?Text('Choose Date',
              style:  Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ):Text('${goalCubit.chosenDate!.day} \\ ${goalCubit.chosenDate!.month} \\ ${goalCubit.chosenDate!.year}',
              style:  Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13),
            ),
            leading:  SvgPicture.asset(AppIcons.dateIcon),
          ),
        ),
      ),
    );
  },
);
  }


