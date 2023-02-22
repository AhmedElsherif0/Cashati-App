import 'package:hive/hive.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/models/goals/goal_model.dart';
import 'package:temp/data/models/goals/repeated_goal_model.dart';

mixin MixinGoals {
  final HiveHelper _hiveDatabase = HiveHelper();
  final DateTime _today = DateTime.now();

  final Box<GoalRepeatedDetailsModel> _goalRepeatedBox = HiveHelper()
      .getBoxName<GoalRepeatedDetailsModel>(boxName: AppBoxes.goalRepeatedBox);

  final Box<GoalModel> _goalBox =
      HiveHelper().getBoxName<GoalModel>(boxName: AppBoxes.goalModel);

  HiveHelper get hiveDatabase => _hiveDatabase;

  get today => _today;

  Box<GoalModel> get goalBox => _goalBox;

  Box<GoalRepeatedDetailsModel> get goalRepeatedBox => _goalRepeatedBox;

  get putNextShownDateFirstAdd => _putNextShownDateFirstAdd;

  DateTime _putNextShownDateFirstAdd(
      {required DateTime startSavingDate, required String repeatType}) {
    switch (repeatType) {

      case 'Daily':
        return startSavingDate;
      case 'Weekly':
        if (

            checkSameDay(date: startSavingDate)) {
          return startSavingDate.add(const Duration(days: 7));
        } else {
          // return expensePaymentDate.add(Duration(days: 7));
          // the right return is below
          return startSavingDate;
        }
      case 'Monthly':
        if (
            //expensePaymentDate.difference(today).inDays==0
            checkSameDay(date: startSavingDate)) {
          return startSavingDate.add(const Duration(days: 30));
        } else {
          return startSavingDate;
        }

      default:
        return startSavingDate;
    }
  }

  bool isEqualToday({required DateTime date}) {
    return (today.day == date.day &&
            today.month == date.month &&
            today.year == date.year)
        ? true
        : false;
  }

  bool checkSameDay({required DateTime date}) {
    int currentTime = DateTime.now().day;
    return date.day == currentTime ? true : false;
  }

  List<GoalRepeatedDetailsModel> getRepeatedGoalsFromRepeatBox() {
    List<GoalRepeatedDetailsModel> repeatedGoals = [];
    try {
      /// get data from box and assign it to dailyExpense List.
      repeatedGoals = goalRepeatedBox.values.toList();
      print('the length :${repeatedGoals.length}');
    } catch (error) {
      print('new error ${error.toString()}');
    }
    return repeatedGoals;
  }

  List<GoalModel> getGoalsFromGoalsBox() {
    List<GoalModel> goalsGroup = [];
    try {
      ///get box name first

      /// get data from box and assign it to dailyExpense List.
      goalsGroup = goalBox.values.toList();
      print('the length :${goalBox.length}');
    } catch (error) {
      print('new error ${error.toString()}');
    }
    return goalsGroup;
  }

  bool checkNoConfirmedAndWeekly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime goalStartSavingDate}) {
    // for showing the payment weekly if it is not the same expense date day
    if (
        //today.difference(expensePayment).inDays!=0&&
        !checkSameDay(date: goalStartSavingDate) &&
            today.difference(nextShownDate).inDays % 7 == 0
            // &&today.difference(lastConfirmedDate).inDays!=0
            &&
            !checkSameDay(date: lastConfirmedDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkNoConfirmedAndMonthly(
      {required DateTime nextShownDate,
      required DateTime lastConfirmedDate,
      required DateTime goalStartSavingDate}) {
    // for showing the payment weekly if he didn't take action
    if (
        //today.difference(expensePayment).inDays!=0&&
        !checkSameDay(date: goalStartSavingDate) &&
            today.difference(nextShownDate).inDays % 30 == 0
            //&&today.difference(lastConfirmedDate).inDays!=0
            &&
            !checkSameDay(date: lastConfirmedDate)
        // &&expensePayment.isAfter(today)
        ) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addGoalToRepeatedBox(GoalModel goalModel) async {
    GoalRepeatedDetailsModel goalRepeatedDetailsModel =
        GoalRepeatedDetailsModel.copyWith(
      goalLastConfirmationDate: today,
      goalIsLastConfirmed: false,
      goal: goalModel,
      goalLastShownDate: today,
      nextShownDate: putNextShownDateFirstAdd(
          startSavingDate: goalModel.goalStartSavingDate,
          repeatType: goalModel.goalSaveAmountRepeat),
    );
    try {
      await goalRepeatedBox.put(goalModel.id, goalRepeatedDetailsModel);
    } catch (error) {
      print("error in add goal to repeated box is ${error.toString()}");
    }

    print("key is ${goalRepeatedDetailsModel.key}");

    print('goal Daily List add ${goalRepeatedBox.length}');
  }

  Future<void> addGoalToBoxFromRepeatedBox(
      {required GoalModel currentGoal, required num? newAmount}) async {
    //TODO if new amount is not same amount so completion Date should change(so we will have to get methods from cubit)
    final GoalModel goalModel = currentGoal;
    goalModel
      ..goalSaveAmount = goalModel.goalSaveAmount
      ..id = currentGoal.id
      ..goalCompletionDate = getCompletionDate(goalModel: goalModel)
      ..goalRemainingPeriod =
          getCompletionDate(goalModel: goalModel).difference(_today).inDays
      ..goalRemainingAmount =
          newAmount != null && newAmount != goalModel.goalSaveAmount
              ? goalModel.goalRemainingAmount - newAmount
              : goalModel.goalRemainingAmount - goalModel.goalSaveAmount;
    try {
      await goalBox.put(goalModel.id, goalModel);
    } catch (error) {
      print(
          'Error in adding Goal from repeated box to box (confirm) is ${error.toString()}');
    }
  }

  int remainingTimes({
    required num cost,
    required num dailySaving,
  }) {
    return (cost / dailySaving).toInt();
  }

  DateTime getCompletionDate({
    required GoalModel goalModel,
  }) {
    final remainingTime = remainingTimes(
        cost: goalModel.goalTotalAmount, dailySaving: goalModel.goalSaveAmount);
    return countCompletionDate(goalModel, remainingTime);
  }

  DateTime countCompletionDate(GoalModel goalModel, int remainingTime) {
    switch (goalModel.goalSaveAmountRepeat) {
      case 'Daily':
        return goalModel.goalStartSavingDate.add(Duration(days: remainingTime));
      case 'Weekly':
        return goalModel.goalStartSavingDate
            .add(Duration(days: remainingTime * 7));
      case 'Monthly':
        return goalModel.goalStartSavingDate
            .add(Duration(days: remainingTime * 30));
      default:
        return goalModel.goalStartSavingDate.add(Duration(days: remainingTime));
    }
  }

  /// checks and actions on confirm goal and no confirmGoal

  bool dailyShowChecking(GoalRepeatedDetailsModel dailyGoal) {
    if (!checkSameDay(date: dailyGoal.goalLastConfirmationDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool weeklyShowChecking(GoalRepeatedDetailsModel weeklyGoal) {
    if (checkSameDay(date: weeklyGoal.nextShownDate) &&
            !checkSameDay(date: weeklyGoal.goalLastConfirmationDate) ||
        checkNoConfirmedAndWeekly(
            nextShownDate: weeklyGoal.nextShownDate,
            lastConfirmedDate: weeklyGoal.goalLastConfirmationDate,
            goalStartSavingDate: weeklyGoal.goal.goalStartSavingDate)) {
      return true;
    } else {
      return false;
    }
  }

  bool monthlyShowChecking(GoalRepeatedDetailsModel monthlyGoal) {
    if (checkSameDay(date: monthlyGoal.nextShownDate) &&
            !checkSameDay(date: monthlyGoal.goalLastConfirmationDate) ||
        checkNoConfirmedAndMonthly(
            nextShownDate: monthlyGoal.nextShownDate,
            lastConfirmedDate: monthlyGoal.goalLastConfirmationDate,
            goalStartSavingDate: monthlyGoal.goal.goalStartSavingDate)) {
      return true;
    } else {
      return false;
    }
  }

// when Yes

  GoalRepeatedDetailsModel editDailyGoalLastShown(
      {required GoalModel goalModel}) {
    /// this goal model is fetched from the repeated model So its key is always the same one
    /// with its repeated model as both have same key and id (when adding goal at first time)
    GoalRepeatedDetailsModel theMatchingDailyExpense =
        goalRepeatedBox.get(goalModel.id)!;

    print(
        'Before Edit Daily ${theMatchingDailyExpense.goalLastConfirmationDate}');
    theMatchingDailyExpense.goalLastConfirmationDate = today;
    theMatchingDailyExpense.goal.goalRemainingAmount =
        goalModel.goalRemainingAmount;
    theMatchingDailyExpense.goal.goalCompletionDate =
        goalModel.goalCompletionDate;
    theMatchingDailyExpense.goal.goalRemainingPeriod =
        goalModel.goalRemainingPeriod;
    theMatchingDailyExpense.nextShownDate = today.add(const Duration(days: 1));
    theMatchingDailyExpense.goalLastShownDate = today;
    return theMatchingDailyExpense;
  }

  Future<void> saveDailyGoalAndAddToRepeatBox(
      {required GoalRepeatedDetailsModel theMatchingGoalinRep,
      required num? newAmount}) async {
    await theMatchingGoalinRep.save();
    await addGoalToBoxFromRepeatedBox(
        currentGoal: theMatchingGoalinRep.goal, newAmount: newAmount);
  }

  Future saveDailyGoalNoConfirm(
      GoalRepeatedDetailsModel theMatchingDailyExpense) async {
    await theMatchingDailyExpense.save();
  }

  Future saveWeeklyGoalNoConfirm(
      GoalRepeatedDetailsModel theMatchingWeeklyExpenseModel) async {
    await theMatchingWeeklyExpenseModel.save();
  }

  Future saveMonthlyGoalNoConfirm(
      GoalRepeatedDetailsModel theMatchingMonthlyExpenseModel) async {
    await theMatchingMonthlyExpenseModel.save();
  }

  GoalRepeatedDetailsModel editWeeklyGoalLastShown(
      {required GoalModel goalModel, required DateTime today}) {
    GoalRepeatedDetailsModel theMatchingWeeklyExpenseModel =
        goalRepeatedBox.get(goalModel.id)!;
    // the right last confirmation date is below
    theMatchingWeeklyExpenseModel.goalLastConfirmationDate = today;
    theMatchingWeeklyExpenseModel.goal.goalRemainingAmount =
        goalModel.goalRemainingAmount;
    theMatchingWeeklyExpenseModel.goal.goalCompletionDate =
        goalModel.goalCompletionDate;
    theMatchingWeeklyExpenseModel.goal.goalRemainingPeriod =
        goalModel.goalRemainingPeriod;
    theMatchingWeeklyExpenseModel.nextShownDate =
        today.add(const Duration(days: 7));
    theMatchingWeeklyExpenseModel.goalLastShownDate = today;
    return theMatchingWeeklyExpenseModel;
  }

  Future saveWeeklyGoalAndAddToRepeatBox(
      {required GoalRepeatedDetailsModel theMatchingWeeklyExpenseModel,
      required num? newAmount}) async {
    await theMatchingWeeklyExpenseModel.save();
    await addGoalToBoxFromRepeatedBox(
        currentGoal: theMatchingWeeklyExpenseModel.goal, newAmount: newAmount);
  }

  GoalRepeatedDetailsModel editMonthlyGoalLastShown(
      {required GoalModel goalModel, required DateTime today}) {
    GoalRepeatedDetailsModel theMatchingMonthlyRepeatedGoal =
        goalRepeatedBox.get(goalModel.id)!;

    theMatchingMonthlyRepeatedGoal.goalLastConfirmationDate = today;
    theMatchingMonthlyRepeatedGoal.goal.goalRemainingAmount =
        goalModel.goalRemainingAmount;
    theMatchingMonthlyRepeatedGoal.goal.goalCompletionDate =
        goalModel.goalCompletionDate;
    theMatchingMonthlyRepeatedGoal.goal.goalRemainingPeriod =
        goalModel.goalRemainingPeriod;
    theMatchingMonthlyRepeatedGoal.nextShownDate =
        today.add(const Duration(days: 30));
    theMatchingMonthlyRepeatedGoal.goalLastShownDate = today;
    return theMatchingMonthlyRepeatedGoal;
  }

  Future saveMonthlyGoalAndAddToRepeatBox(
      {required GoalRepeatedDetailsModel theMatchingMonthlyExpenseModel,
      required num? NewAmount}) async {
    await theMatchingMonthlyExpenseModel.save();
    await addGoalToBoxFromRepeatedBox(
        currentGoal: theMatchingMonthlyExpenseModel.goal, newAmount: NewAmount);
  }

}
