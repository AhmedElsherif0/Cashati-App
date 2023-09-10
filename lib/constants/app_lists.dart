import 'package:flutter/material.dart';
import 'package:temp/constants/app_icons.dart';
import '../data/models/cashati_employer_model.dart';
import '../data/models/subcategories_models/expense_subcaegory_model.dart';

class AppConstantList {
  final SubCategory addMoreOption = SubCategory.copyWith(
    id: 'feverrsssrr',
    mainCategoryName: 'AddMore',
    subCategoryName: 'Add More',
    subCategoryIconName: AppIcons.addAppIcon,
  );

  final List<SubCategory> expenseHomeFixedList = [
    SubCategory.copyWith(
      id: 'ssfsf55',
      mainCategoryName: 'Home',
      subCategoryName: 'Transportation',
      subCategoryIconName: AppIcons.buildAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Home',
      subCategoryName: 'Food',
      subCategoryIconName: AppIcons.fbAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefgg99',
      mainCategoryName: 'Home',
      subCategoryName: 'Random',
      subCategoryIconName: AppIcons.buildAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefggs99',
      mainCategoryName: 'Home',
      subCategoryName: 'Try1',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefefefggs99',
      mainCategoryName: 'Home',
      subCategoryName: 'Try2',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefef4rggs99',
      mainCategoryName: 'Home',
      subCategoryName: 'Try3',
      subCategoryIconName: AppIcons.buildAppIcon,
    ),
    SubCategory.copyWith(
      id: 'rf33f',
      mainCategoryName: 'Home',
      subCategoryName: 'Try4',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'rf33wwwwf',
      mainCategoryName: 'Home',
      subCategoryName: 'Try5',
      subCategoryIconName: AppIcons.pauseAppIcon,
    ),
  ];

  static const List<IconData> expHomeIcons = [
    Icons.ten_k,
    Icons.star,
    Icons.vaccines_outlined,
    Icons.vaccines_outlined,
    Icons.abc_outlined,
    Icons.access_alarm_sharp,
    Icons.add_chart_outlined,
  ];

  final List<SubCategory> expensePersonalFixedList = [
    SubCategory.copyWith(
      id: 'ssfsf55',
      subCategoryName: 'Personal1',
      mainCategoryName: 'Personal',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal2',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefgg99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal3',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefggs99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal4',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefefefggs99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal5',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefef4rggs99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal6',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'rf33f',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal7',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'rf33wwwwf',
      mainCategoryName: 'Personal',
      subCategoryName: 'Personal8',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
  ];

  final List<SubCategory> expenseBusinessFixedList = [
    SubCategory.copyWith(
      id: 'ssfsf55',
      mainCategoryName: 'Business',
      subCategoryName: 'Business1',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Business',
      subCategoryName: 'Business2',
      subCategoryIconName: AppIcons.keyAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefgg99',
      mainCategoryName: 'Business',
      subCategoryName: 'Business3',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefggs99',
      mainCategoryName: 'Business',
      subCategoryName: 'Business4',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefefefggs99',
      mainCategoryName: 'Business',
      subCategoryName: 'Business5',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefef4rggs99',
      mainCategoryName: 'Business',
      subCategoryName: 'Business6',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'rf33f',
      mainCategoryName: 'Business',
      subCategoryName: 'Business7',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'rf33wwwwf',
      mainCategoryName: 'Business',
      subCategoryName: 'Business8',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
  ];

  final List<MaterialColor> colorsList = [
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
  Map<String, String> appBarTitle = {
    'home': 'Home',
    'confirmPayingToday': 'Confirm Paying Today',
    'statisticsExpenses': 'Statistics expenses',
    'statisticsIncome': 'Statistics Income',
    'settings': 'Settings'
  };

  final Map<String, IconData> iconsOfApp = {
    AppIcons.fbAppIcon: Icons.fastfood,
    AppIcons.keyAppIcon: Icons.car_crash_outlined,
    AppIcons.sevenAppIcon: Icons.seven_k,
    AppIcons.titleAppIcon: Icons.title,
    AppIcons.buildAppIcon: Icons.build,
    AppIcons.vaccinesOutlinedAppIcon: Icons.vaccines_outlined,
    AppIcons.repeatAppIcon: Icons.repeat,
    AppIcons.pauseAppIcon: Icons.pause,
    AppIcons.dangerousAppIcon: Icons.dangerous,
    AppIcons.addAppIcon: Icons.add,
  };

  final List<SubCategory> incomeFixedSubFixedList = [
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Fixed',
      subCategoryName: 'Part Time',
      subCategoryIconName: AppIcons.repeatAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefsi2sd5',
      mainCategoryName: 'Fixed',
      subCategoryName: 'Full Time',
      subCategoryIconName: AppIcons.vaccinesOutlinedAppIcon,
    ),
  ];

  final List<SubCategory> incomeVariableSubFixedList = [
    SubCategory.copyWith(
      id: 'odfie33fi25',
      mainCategoryName: 'Variable',
      subCategoryName: 'Freelance Programming',
      subCategoryIconName: AppIcons.dangerousAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefsi2ssdd5',
      mainCategoryName: 'Variable',
      subCategoryName: 'Freelance Marketing',
      subCategoryIconName: AppIcons.buildAppIcon,
    ),
  ];

  static const List<String> englishDays = [
    "All",
    "Fri",
    "Sat",
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu"
  ];
  static const List<String> arabicDays = [
    "الكل",
    "الجمعة",
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس"
  ];
  static const List<CashatiEmployerModel> cashatiWorkers=const [
    CashatiEmployerModel(
      email: "mohamedmounierabbas@gmail.com",
      jobTitle: "Software Engineer And Team Leader",
      name: "Mohamed Mounier Abbas"
    ),
    CashatiEmployerModel(
      email: "ahmed.elsherif010@gmail.com",
      jobTitle: "Software Engineer",
      name: "Ahmed Elsherif"
    ),
  ];
}
