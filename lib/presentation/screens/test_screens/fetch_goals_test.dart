import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp/business_logic/cubit/goals_cubit/goals_cubit.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';
import 'package:temp/presentation/widgets/common_texts/green_text.dart';

class FetchGoalsTestScreen extends StatefulWidget {
  const FetchGoalsTestScreen({Key? key}) : super(key: key);

  @override
  State<FetchGoalsTestScreen> createState() => _FetchGoalsTestScreenState();
}


class _FetchGoalsTestScreenState extends State<FetchGoalsTestScreen> {

  @override
  void initState() {
   BlocProvider.of<GoalsCubit>(context).fetchAllGoals();
   BlocProvider.of<GoalsCubit>(context).fetchRepeatedGoals();
  }
  @override
  Widget build(BuildContext context) {
    final goalCubit = BlocProvider.of<GoalsCubit>(context);

    return Scaffold(
      body: BlocBuilder<GoalsCubit, GoalsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
              ),
              GreenText(text: 'All Goals Box'),
              goalsWidget(goalCubit.goals),
              SizedBox(
                height: 50,
              ),
              GreenText(text: 'All Repeated Goals Box'),
              repeatedGoalsWidget(goalCubit.goalsRepeated)
            ],
          )
          );
        },
      ),
    );
  }

  Widget goalsWidget(List<GoalModel> goals) {
    return Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: goals.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(20)
              ),
              height: 100,
              width: 150,
              child: ExpansionTile(
                title: Text(goals[index].goalName),
                children: [
                  Text('${goals[index].goalRemainingPeriod}'),
                  Text('${goals[index].goalRemainingPeriod}'),
                  Text('${goals[index].goalRemainingPeriod}'),
                  Text('${goals[index].goalRemainingPeriod}'),
                  Text('${goals[index].goalRemainingPeriod}'),
                ],
              ),
            );
          }),
    );
  }

  Widget repeatedGoalsWidget(List<GoalRepeatedDetailsModel> goalsRepeated) {
    return Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: goalsRepeated.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.amber.shade200,
              borderRadius: BorderRadius.circular(20)
              ),
              height: 150,
              width: 200,

              child: ExpansionTile(
                title: Text(goalsRepeated[index].goal.goalName),
                children: [
                  Text('${goalsRepeated[index].goalLastShownDate}'),
                  Text(goalsRepeated[index].nextShownDate.toString()),
                  Text(
                      '${goalsRepeated[index].goal.goalRemainingAmount}'),
                  Text(
                      '${goalsRepeated[index].goal.goalRemainingPeriod}'),
                  Text(
                      '${goalsRepeated[index].goal.goalSaveAmountRepeat}'),
                ],
              ),
            );
          }),
    );
  }
}
