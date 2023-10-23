import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../business_logic/cubit/global_cubit/global_cubit.dart';

mixin FormatsMixin{

  String currencyFormat(BuildContext context,num currency) {
    bool isEnglish = translator.activeLanguageCode == 'en';
    final engCurrency = isEnglish ? context.read<GlobalCubit>().curr : '';
    final arabicCurrency = isEnglish ? '' : context.read<GlobalCubit>().curr1;
    return '${NumberFormat.currency(
        symbol: arabicCurrency ,
        locale: isEnglish ? 'en_US' : 'ar_EG')
        .format(currency)}$engCurrency';
  }

  String formatDayDate(DateTime inputDate, String currentLocal) =>
      DateFormat('d / MM/ yyyy', currentLocal).format(inputDate.toLocal());

  String formatDayWeek(DateTime inputDate, String currentLocal) =>
      DateFormat('EEE', currentLocal).format(inputDate.toLocal());

  String formatWeekDate(DateTime inputDate, String currentLocal) {

    if(DateFormat(' MM / yyyy', currentLocal)
        .format(inputDate.toLocal()).trim().startsWith("0")){

      return DateFormat(' MM / yyyy', currentLocal)
          .format(inputDate.toLocal()).replaceFirst("0", "");
    }else{
      return DateFormat(' MM / yyyy', currentLocal)
          .format(inputDate.toLocal());
    }
  }



}