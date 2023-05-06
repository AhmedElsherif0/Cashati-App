mixin HelperClass {
   List<String>getWeekRange({required DateTime chosenDay}){

    int lastday = DateTime(chosenDay.year,chosenDay.month!=12? chosenDay.month + 1:1, 0).day;
    final chosenMonth = chosenDay.month;

    return ['From 1 \\ $chosenMonth   To  7 \\ $chosenMonth','From 8 \\ $chosenMonth   To  15 \\ $chosenMonth','From 16 \\ $chosenMonth   To  23 \\ $chosenMonth','From 24 \\ $chosenMonth   To  $lastday \\ $chosenMonth'];
  }
}