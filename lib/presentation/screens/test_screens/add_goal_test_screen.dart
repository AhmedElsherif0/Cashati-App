import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/constants/app_icons.dart';
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
  final goalCub=  BlocProvider.of<GoalsCubit>(context);
    return Scaffold(
      body: Column(
        children: [
          EditableInfoField(
            hint: 'Add Goal Name',
            IconName: AppIcons.amountIcon,
            textEditingController: goalName,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 50,),
          EditableInfoField(
            hint: 'Add Goal Cost',
            IconName: AppIcons.amountIcon,
            textEditingController: goalCost,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 50,),
          EditableInfoField(
            hint: 'Add Saving style',
            IconName: AppIcons.amountIcon,
            textEditingController: savingAmount,
            keyboardType: TextInputType.name,
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
          CustomElevatedButton(onPressed: () {

          }, text: 'Add Goal')
        ],
      ),
    );
  }
}
