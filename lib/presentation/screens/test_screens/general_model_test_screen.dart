/*
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:temp/constants/app_strings.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/models/statistics/general_stats_model.dart';

class GeneralModelTestScreen extends StatefulWidget {
  const GeneralModelTestScreen({Key? key}) : super(key: key);

  @override
  State<GeneralModelTestScreen> createState() => _GeneralModelTestScreenState();
}

class _GeneralModelTestScreenState extends State<GeneralModelTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ValueListenableBuilder<Box<GeneralStatsModel>>(
              valueListenable:
                  Hive.box<GeneralStatsModel>(AppBoxes.generalStatisticsBox).listenable(),
              builder: (context, box, widget) {
                return ListView.builder(
                  itemCount: box.values.length,
                    itemBuilder: (context,index){
                      GeneralStatsModel item =box.values.cast<GeneralStatsModel>().toList()[index];
                      return Card(
                    child: Text(item.id),
                  );
                });
              }),
        ),
      ),
    );
  }
}
*/
