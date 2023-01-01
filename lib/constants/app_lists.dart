import 'package:flutter/material.dart';
import 'package:temp/data/models/subcategories_models/income_subcaegory_model.dart';

import '../data/models/subcategories_models/expense_subcaegory_model.dart';

final SubCategoryExpense addMoreOption= SubCategoryExpense.copyWith(
    id: 'feverrrr',
    mainCategoryExpenseName: 'Home',
    subCategoryExpenseName: 'Add More',
    subCategoryExpenseColor: 'red',
    subCategoryExpenseIconName: 'qdqdqd',
    subCategoryExpenseIconCodePoint: Icons.minimize.codePoint);
final SubCategoryIncome addMoreOptionIncome= SubCategoryIncome.copyWith(
    id: 'feverrsssrr',
    mainCategoryIncomeName: 'AddMore',
    subCategoryIncomeName: 'Add More',
    subCategoryIncomeColor: 'red',
    subCategoryIncomeIconName: 'qdqdqd',
    subCategoryIncomeCodePoint: Icons.add.codePoint);

 final List<SubCategoryExpense> expenseHomeFixedList=[
  SubCategoryExpense.copyWith(
      id: 'ssfsf55',
      subCategoryExpenseName: 'Transportation',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint),
  SubCategoryExpense.copyWith(
    id: 'odfiefi25',
    mainCategoryExpenseName: 'Home',
    subCategoryExpenseName: 'Food',
    subCategoryExpenseColor: 'red',
    subCategoryExpenseIconName: 'sss',
    subCategoryExpenseIconCodePoint: Icons.star.codePoint,
  ),
  SubCategoryExpense.copyWith(
      id: 'efefgg99',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseName: 'Random',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefggs99',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseName: 'Try1',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefefefggs99',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseName: 'Try2',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefef4rggs99',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseName: 'Try3',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'rf33f',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseName: 'Try4',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'rf33wwwwf',
      mainCategoryExpenseName: 'Home',
      subCategoryExpenseName: 'Try5',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
];
final List<SubCategoryExpense> expensePersonalFixedList=[
  SubCategoryExpense.copyWith(
      id: 'ssfsf55',
      subCategoryExpenseName: 'Personal1',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint),
  SubCategoryExpense.copyWith(
    id: 'odfiefi25',
    mainCategoryExpenseName: 'Personal',
    subCategoryExpenseName: 'Personal2',
    subCategoryExpenseColor: 'red',
    subCategoryExpenseIconName: 'sss',
    subCategoryExpenseIconCodePoint: Icons.star.codePoint,
  ),
  SubCategoryExpense.copyWith(
      id: 'efefgg99',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseName: 'Personal3',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefggs99',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseName: 'Personal4',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefefefggs99',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseName: 'Personal5',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefef4rggs99',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseName: 'Personal6',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'rf33f',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseName: 'Personal7',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'rf33wwwwf',
      mainCategoryExpenseName: 'Personal',
      subCategoryExpenseName: 'Personal8',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
];
final List<SubCategoryExpense> expenseBusinessFixedList=[
  SubCategoryExpense.copyWith(
      id: 'ssfsf55',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business1',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.ten_k.codePoint),
  SubCategoryExpense.copyWith(
    id: 'odfiefi25',
    mainCategoryExpenseName: 'Business',
    subCategoryExpenseName: 'Business2',
    subCategoryExpenseColor: 'red',
    subCategoryExpenseIconName: 'sss',
    subCategoryExpenseIconCodePoint: Icons.star.codePoint,
  ),
  SubCategoryExpense.copyWith(
      id: 'efefgg99',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business3',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefggs99',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business4',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefefefggs99',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business5',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'efefef4rggs99',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business6',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'rf33f',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business7',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
  SubCategoryExpense.copyWith(
      id: 'rf33wwwwf',
      mainCategoryExpenseName: 'Business',
      subCategoryExpenseName: 'Business8',
      subCategoryExpenseColor: 'red',
      subCategoryExpenseIconName: 'sss',
      subCategoryExpenseIconCodePoint: Icons.vaccines_outlined.codePoint),
];
 final List<MaterialColor> colorsList=[
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.indigo,
  Colors.pink,
  Colors.indigo,
  Colors.green,
  Colors.purple,
  Colors.blue,
  Colors.red,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.indigo,
  Colors.pink,
  Colors.indigo,
];

final List<SubCategoryIncome> incomeFixedSubFixedList=[

  SubCategoryIncome.copyWith(
    id: 'odfiefi25',
    mainCategoryIncomeName: 'Fixed',
    subCategoryIncomeName: 'Part Time',
    subCategoryIncomeColor: 'red',
    subCategoryIncomeIconName: 'sss',
    subCategoryIncomeCodePoint: Icons.star.codePoint,
  ),
  SubCategoryIncome.copyWith(
    id: 'odfiefsi2sd5',
    mainCategoryIncomeName: 'Fixed',
    subCategoryIncomeName: 'Full Time',
    subCategoryIncomeColor: 'red',
    subCategoryIncomeIconName: 'sss',
    subCategoryIncomeCodePoint: Icons.star.codePoint,
  ),

];

final List<SubCategoryIncome> incomeVariableSubFixedList=[

  SubCategoryIncome.copyWith(
    id: 'odfie33fi25',
    mainCategoryIncomeName: 'Variable',
    subCategoryIncomeName: 'Freelance Programming',
    subCategoryIncomeColor: 'red',
    subCategoryIncomeIconName: 'sss',
    subCategoryIncomeCodePoint: Icons.star.codePoint,
  ),
  SubCategoryIncome.copyWith(
    id: 'odfiefsi2ssdd5',
    mainCategoryIncomeName: 'Variable',
    subCategoryIncomeName: 'Freelance Marketing',
    subCategoryIncomeColor: 'red',
    subCategoryIncomeIconName: 'sss',
    subCategoryIncomeCodePoint: Icons.star.codePoint,
  ),

];