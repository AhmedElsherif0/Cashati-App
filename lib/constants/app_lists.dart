import 'package:flutter/material.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/presentation/styles/colors.dart';

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
      id: 'ashrafsf55',
      mainCategoryName: 'Home',
      subCategoryName: 'Drinks',
      subCategoryIconName: AppIcons.drinks,
    ),
    SubCategory.copyWith(
      id: 'ssfsf55',
      mainCategoryName: 'Home',
      subCategoryName: 'Gas',
      subCategoryIconName: AppIcons.gas,
    ),
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Home',
      subCategoryName: 'Food',
      subCategoryIconName: AppIcons.fastFood,
    ),
    SubCategory.copyWith(
      id: 'efefgg99',
      mainCategoryName: 'Home',
      subCategoryName: 'Electricity',
      subCategoryIconName: AppIcons.electricity,
    ),
    SubCategory.copyWith(
      id: 'efefggs99',
      mainCategoryName: 'Home',
      subCategoryName: 'Rent',
      subCategoryIconName: AppIcons.transportation,
    ),
    SubCategory.copyWith(
      id: 'efefefefggs99',
      mainCategoryName: 'Home',
      subCategoryName: 'Taxes',
      subCategoryIconName: AppIcons.taxes,
    ),
    SubCategory.copyWith(
      id: 'efefef4rggs99',
      mainCategoryName: 'Home',
      subCategoryName: 'Internet',
      subCategoryIconName: AppIcons.internet,
    ),
    SubCategory.copyWith(
      id: 'rf33f',
      mainCategoryName: 'Home',
      subCategoryName: 'Water',
      subCategoryIconName: AppIcons.water,
    ),
    SubCategory.copyWith(
      id: 'rf33wwwFFf',
      mainCategoryName: 'Home',
      subCategoryName: 'Random',
      subCategoryIconName: AppIcons.pauseAppIcon,
    ),
  ];

  final List<SubCategory> expensePersonalFixedList = [
    SubCategory.copyWith(
      id: 'ssfsf55',
      subCategoryName: 'Clothing',
      mainCategoryName: 'Personal',
      subCategoryIconName: AppIcons.clothing,
    ),
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Personal',
      subCategoryName: 'Eating out',
      subCategoryIconName: AppIcons.fastFood,
    ),
    SubCategory.copyWith(
      id: 'efefgg99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Healthcare',
      subCategoryIconName: AppIcons.healthCare,
    ),
    SubCategory.copyWith(
      id: 'efefggs99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Movies',
      subCategoryIconName: AppIcons.movie,
    ),
    SubCategory.copyWith(
      id: 'efefefefggs99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Sporting',
      subCategoryIconName: AppIcons.sports,
    ),
    SubCategory.copyWith(
      id: 'efefef4rggs99',
      mainCategoryName: 'Personal',
      subCategoryName: 'Events',
      subCategoryIconName: AppIcons.events,
    ),
    SubCategory.copyWith(
      id: 'rf33f',
      mainCategoryName: 'Personal',
      subCategoryName: 'Vacations',
      subCategoryIconName: AppIcons.fastFood,
    ),
    SubCategory.copyWith(
      id: 'rf33wwwwf',
      mainCategoryName: 'Personal',
      subCategoryName: 'Transportation',
      subCategoryIconName: AppIcons.transportation,
    ),
  ];

  final List<SubCategory> expenseBusinessFixedList = [
    SubCategory.copyWith(
      id: 'ssfsf55',
      mainCategoryName: 'Business',
      subCategoryName: 'Salaries',
      subCategoryIconName: AppIcons.taxes,
    ),
    SubCategory.copyWith(
      id: 'ssfsaalsf55',
      mainCategoryName: 'Business',
      subCategoryName: 'Insurance',
      subCategoryIconName: AppIcons.healthCare,
    ),
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Business',
      subCategoryName: 'Tools',
      subCategoryIconName: AppIcons.buildAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefi2315',
      mainCategoryName: 'Business',
      subCategoryName: 'Subscriptions',
      subCategoryIconName: AppIcons.repeatAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefgg99',
      mainCategoryName: 'Business',
      subCategoryName: 'Equipment',
      subCategoryIconName: AppIcons.equipment,
    ),
    SubCategory.copyWith(
      id: 'efefggs99',
      mainCategoryName: 'Business',
      subCategoryName: 'materials',
      subCategoryIconName: AppIcons.vaccinesOutlinedAppIcon,
    ),
    SubCategory.copyWith(
      id: 'efefefefggs99',
      mainCategoryName: 'Business',
      subCategoryName: 'Marketing',
      subCategoryIconName: AppIcons.marketing,
    ),
  ];

  final List<Color> colorsList = [
    Colors.red,
    Colors.green.shade300,
    Colors.blue,
    Colors.purple,
    Colors.indigo,
    AppColor.pineGreen,
    Colors.pink,
    Colors.indigo.shade900,
    Colors.green,
    Colors.purple,
    Colors.blue.shade200,
    AppColor.primaryColor,
    Color(0xffEF9A9A),
    AppColor.mintGreen,
    AppColor.darkGrey,
    Colors.greenAccent,
    Colors.blue,
    AppColor.primaryColor,
    Colors.purple,
    Colors.indigo.shade400,
    Colors.pink,
    AppColor.murdochGreen,
    Colors.indigo.shade700,
  ];

  final Map<String, IconData> iconsOfApp = {
    AppIcons.fastFood: Icons.fastfood,
    AppIcons.drinks: Icons.local_drink_outlined,
    AppIcons.transportation: Icons.directions_subway_sharp,
    AppIcons.sevenAppIcon: Icons.seven_k,
    AppIcons.titleAppIcon: Icons.title,
    AppIcons.buildAppIcon: Icons.build,
    AppIcons.vaccinesOutlinedAppIcon: Icons.vaccines_outlined,
    AppIcons.repeatAppIcon: Icons.repeat,
    AppIcons.pauseAppIcon: Icons.pause,
    AppIcons.dangerousAppIcon: Icons.dangerous,
    AppIcons.gas: Icons.gas_meter_outlined,
    AppIcons.electricity: Icons.energy_savings_leaf_rounded,
    AppIcons.taxes: Icons.attach_money,
    AppIcons.internet: Icons.wifi,
    AppIcons.water: Icons.water_drop_outlined,
    AppIcons.clothing: Icons.accessibility,
    AppIcons.healthCare: Icons.health_and_safety_outlined,
    AppIcons.movie: Icons.movie_creation_outlined,
    AppIcons.sports: Icons.sports_cricket,
    AppIcons.events: Icons.emoji_events,
    AppIcons.equipment: Icons.wind_power_rounded,
    AppIcons.marketing: Icons.ads_click_sharp,
    AppIcons.perHour: Icons.timer_outlined,
    AppIcons.contract: Icons.content_paste,
    AppIcons.partTime: Icons.six_ft_apart,
    AppIcons.remote: Icons.settings_remote,
    AppIcons.addAppIcon: Icons.add,
  };

  final List<SubCategory> incomeFixedSubFixedList = [
    SubCategory.copyWith(
      id: 'odfiefi25',
      mainCategoryName: 'Fixed',
      subCategoryName: 'Part Time',
      subCategoryIconName: AppIcons.partTime,
    ),
    SubCategory.copyWith(
      id: 'odfiefsi2sd5',
      mainCategoryName: 'Fixed',
      subCategoryName: 'Full Time',
      subCategoryIconName: AppIcons.vaccinesOutlinedAppIcon,
    ),
    SubCategory.copyWith(
      id: 'odfiefsi2ssdd5',
      mainCategoryName: 'Variable',
      subCategoryName: 'Contract',
      subCategoryIconName: AppIcons.contract,
    ),
    SubCategory.copyWith(
      id: 'odfiefassi2sd5',
      mainCategoryName: 'Fixed',
      subCategoryName: 'Remote',
      subCategoryIconName: AppIcons.remote,
    ),
    SubCategory.copyWith(
      id: 'onFassi2sd1',
      mainCategoryName: 'Fixed',
      subCategoryName: 'Hybrid',
      subCategoryIconName: AppIcons.repeatAppIcon,
    ),
  ];

  final List<SubCategory> incomeVariableSubFixedList = [
    SubCategory.copyWith(
      id: 'odfie33fi25',
      mainCategoryName: 'Variable',
      subCategoryName: 'Freelance',
      subCategoryIconName: AppIcons.remote,
    ),
    SubCategory.copyWith(
      id: 'odfiefsi2ssdd55',
      mainCategoryName: 'Variable',
      subCategoryName: 'Per Project',
      subCategoryIconName: AppIcons.contract,
    ),
    SubCategory.copyWith(
      id: 'odfiefsi2ssdd5',
      mainCategoryName: 'Variable',
      subCategoryName: 'Per Hour',
      subCategoryIconName: AppIcons.perHour,
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
  static const List<CashatiEmployerModel> cashatiWorkers = [
    CashatiEmployerModel(
        email: "mohamedmounierabbas@gmail.com",
        jobTitle: "Software Engineer And Team Leader",
        name: "Mohamed Mounier Abbas"),
    CashatiEmployerModel(
        email: "ahmed.elsherif010@gmail.com",
        jobTitle: "Software Engineer",
        name: "Ahmed Elsherif"),
    CashatiEmployerModel(
        email: "esraaelemam974@gmail.com",
        jobTitle: "Ui And Ux Designer Team Leader ",
        name: "Esraa Elemam Badwy"),
    CashatiEmployerModel(
        email: "shurouq.ayyad.2003@gmail.com",
        jobTitle: "Ui And Ux Designer",
        name: "Shuroq Hassan Ayyad"),
    CashatiEmployerModel(
        email: "mahmoudelsaey.95@gmail.com",
        jobTitle: "Ui And Ux Designer",
        name: "Mahmoud El Saey"),
    CashatiEmployerModel(
        email: "hussamibrahiim0@gmail.com",
        jobTitle: "Logo Designer",
        name: "Hossam Ibrahim Mohamed"),
  ];
}
