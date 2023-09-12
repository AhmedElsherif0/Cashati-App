import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:temp/presentation/styles/colors.dart';

class RateAppWidget extends StatelessWidget {
   RateAppWidget({super.key,});
   // final RateMyApp rateMyApp;


   @override
  Widget build(BuildContext context) {
     return RateAppInitWidget(builder: (rateApp)=> ListTile(
       onTap: ()async{
         await rateApp.showStarRateDialog(context,    title: 'Rate this app', // The dialog title.
           message: 'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
           actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
             return [
               RateMyAppRateButton(

                 rateApp,
                 text: "ok",
                 callback: () => rateApp.launchStore(),

                 // onPressed: () async {
                 //   print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
                 //   // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                 //   // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                 //  // await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                 //   await rateMyApp.launchStore();
                 //   Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                 // },
               ),
             ];
           },
           ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
           dialogStyle: const DialogStyle( // Custom dialog styles.
             titleAlign: TextAlign.center,
             messageAlign: TextAlign.center,
             messagePadding: EdgeInsets.only(bottom: 20),
           ),
           starRatingOptions: const StarRatingOptions(), // Custom star bar rating options.
           onDismissed: () => rateApp.callEvent(RateMyAppEventType.laterButtonPressed),);
       },
       leading: Icon(Icons.star_border_outlined,color: AppColor.primaryColor,),
       title: Text("Rate Cashati",),
       subtitle: Text("Rate our app so we should be able to enhance our service , thanks for your feedback in advance.",style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10.dp,fontWeight: FontWeight.w300,color: AppColor.subTitleColor),),
     ),);

  }

}


class RateAppInitWidget extends StatefulWidget {

  final Widget Function(RateMyApp) builder;
  @override
  _RateAppInitWidgetState createState() => _RateAppInitWidgetState();

  const RateAppInitWidget({required this.builder,Key? key}):super(key: key);
}

class _RateAppInitWidgetState extends State<RateAppInitWidget> {
  RateMyApp rateMyApp= RateMyApp(
      minDays: 0,
      googlePlayIdentifier:playStoreId,

      minLaunches: 0
  );
  static const playStoreId="com.example.temp";
  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        minDays: 0,
        googlePlayIdentifier:playStoreId,
        minLaunches: 0,
        remindDays: 10,
      ),
      onInitialized: (context,rateApp){
        setState(() {
          rateMyApp=rateApp;
        });

      },
      builder: (context)=>rateMyApp==null?const Center(child: CircularProgressIndicator(),):
      widget.builder(rateMyApp),

    );
  }
}
