import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit() : super(GoalsInitial());
  String choseRepeat = 'Choose Repeat';

  List<DropdownMenuItem<String>> dropDownChannelItems = [
    DropdownMenuItem(child: Text('Daily'), value: 'Daily'),
    DropdownMenuItem(child: Text('Weekly'), value: 'Weekly'),
    DropdownMenuItem(
      child: Text('Monthly'),
      value: 'Monthly',
    ),

  ];
  chooseRepeat(String value) {
    choseRepeat = value;
    emit(ChoosedRepeatState());
  }
}
